import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Customwidgets/bottombar.dart';
import 'package:weather_app/Customwidgets/favoritebutton.dart';
import 'package:weather_app/Customwidgets/forecastbutton.dart';
import 'package:weather_app/Customwidgets/gradient.dart';
import 'package:weather_app/Customwidgets/settingsbutton.dart';
import 'package:weather_app/Providres/SQL/mySqdb_provider.dart';
import 'package:weather_app/Providres/SQL/weathermodel.dart';
import 'package:weather_app/Screens/Search.dart';
import 'package:weather_app/Screens/Settings.dart';
import 'package:weather_app/services/location.dart';

import '../Providres/weather_provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


final location current_location = location();
bool get_location=false;
late Map<String, dynamic> weatherData = {};
var temperature = 0.0;




@override
  void initState() {
   
 final weatherProvider = Provider.of<WeatherProvider>(context  , listen: false);
current_location.getCurrentLocation().then((value1) => 
weatherProvider.fetchWeather( value1 ).then((_) {
  Provider.of<mySqdb>(context , listen: false ).con(weathermodel( id:weatherProvider.id, lable: value1 ));
setState(() {
  weatherData = weatherProvider.currentWeather;
  get_location = true;
  temperature = weatherProvider.temperature;

});
}

)
);
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

  final weatherProvider = Provider.of<WeatherProvider>(context );
  final mydbprovider = Provider.of<mySqdb>(context );


    return Scaffold(
      drawer:Drawer(
        backgroundColor: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.6,
        
        child:Settings() ,)
      
      ,
      body: 
      SingleChildScrollView(
        child: Stack(
          
          alignment: Alignment.bottomCenter,
          children:[
        Container(
          height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/background.png",),fit: BoxFit.fill)),
        
        ), 

      gradient(temperature: temperature,)  ,
      bottombar  (temperature: temperature,)  ,

            
             Container(   
              
               height: MediaQuery.of(context).size.height,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [         
                 search() ,   
                
               !get_location?
               Center(child: Column(
                 children: [
                  Text("Loading Current Location"),
                   CircularProgressIndicator(),
                 ],
               ))   :    
               weatherData.isEmpty?Container():  Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                          
                           Text(weatherProvider.City_name, style: TextStyle(fontSize: 25)),
                             IconButton(
                              icon:
                             
                             
                              Icon(
                                Provider.of<mySqdb>(context ,listen: false ).col?
                                 Icons.favorite_border
                                :
                                
                                Icons.favorite ,
                              color:
                     
                     Provider.of<mySqdb>(context ,listen: false ).col?
                     Colors.white
                     :
                      Colors.red,), onPressed: () {
                     mydbprovider.insert(weathermodel( id:weatherProvider.id, lable: weatherProvider.City_name ));
                     },),
                         ],
                       ),
                       SizedBox(height: 5),
                       Text(
               '${weatherProvider.mainWeather} - ${weatherProvider.description}',
               style: TextStyle(fontSize: 18),
                       ),
                       SizedBox(height: 10),
                       Text(
               'Temperature: ${weatherProvider.getFormattedTemperature(weatherProvider.temperature)}',
               style: TextStyle(fontSize: 18),
                       ),
                       SizedBox(height: 10),
                       Text(
               'Humidity: ${weatherProvider.humidity}%',
               style: TextStyle(fontSize: 18),
                       ),
                       SizedBox(height: 10),
                       Text(
               'Wind Speed: ${weatherProvider.windSpeed.toStringAsFixed(1)} m/s',
               style: TextStyle(fontSize: 18),
                       ),
                   
               ],
                       ),
                     ),
                     
                     
                     SizedBox(height: 60,)

                ],
               ),
             ),
          settingsbutton(),
          favoritebutton(),
          forecastbutton(),


        // Point design on top and above temperature
          Container(    height: MediaQuery.of(context).size.height,
            child: Align(
                  alignment: Alignment(0,0.58),
                  child:   Stack(
                  alignment: Alignment.center,
                  children: [
                  
                  Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 0.5 ,color: Colors.white )),
                  
                  ),
                  
                  Container(
                  decoration: BoxDecoration(
            color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
            ),
                   width: 5,height: 5,)
                  ],
                  ),
                  ),
          ),
        Container(    height: MediaQuery.of(context).size.height,
          child: Align(
          alignment: Alignment(0.02,0.52),
          child:   
          Container(
            width: 40,
            height: 15,
            decoration: BoxDecoration(
          color: Color(0xFF253F5D),
          borderRadius: BorderRadius.all(Radius.circular(5)),
             ),
          child: Center(child: Text("${weatherProvider.getFormattedTemperature(weatherProvider.temperature)}",style: TextStyle(fontSize: 9,color: Colors.white))),
          ),
          
          
          ),
        ),
        
          
          ]
        ),
      ),
    );
  }
}
