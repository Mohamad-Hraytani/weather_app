import 'dart:async';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app/Providres/SQL/weathermodel.dart';
import 'package:weather_app/Providres/weather_provider.dart';
import 'package:weather_app/Screens/Home_screen.dart';





import '../Providres/SQL/mySqdb_provider.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  @override
  Widget build(BuildContext context) {


    return Consumer<mySqdb>(builder: (ctx , cur , _){

      return Scaffold(
        floatingActionButton: FloatingActionButton(
backgroundColor: Colors.red.shade200,
child: Icon(Icons.home),
          onPressed: (){


   

Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> HomeScreen()));


 
          },
        ),
        body: Container(
          child: FutureBuilder(
              future: Provider.of<mySqdb>(context,listen: false).getAll('weather', 'weather_db'),
              builder:
                  (BuildContext context, AsyncSnapshot<List<weathermodel>> snapshot) {
                print(snapshot.data);

                switch (snapshot.connectionState) {
              
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());

                  case ConnectionState.none:
                    return Center(child: Text('error'));

                  case ConnectionState.done: 
                    if (snapshot
                        .hasError) 
                      return Center(child: Text(snapshot.error.toString()));

                    if (!snapshot.hasData)
                      return Center(child: Text('no data'));
                    return Favorite_cities(context, snapshot.data!.cast(), cur);
  
                  default:
                    return Center(child: Text('no connection'));
                   
                }
              }),
        ),
      );}
    );
  }

  Widget Favorite_cities(BuildContext context, List<weathermodel> weather ,mySqdb cur) {
      var mode = MediaQuery.of(context).orientation; 

      final weatherProvider = Provider.of<WeatherProvider>(context );
  final mydbrovider = Provider.of<mySqdb>(context );
var size = MediaQuery.of(context).size;
    return Consumer<mySqdb>(
      builder:  (ctx, currentitem, _){
      return ListView.builder(
        itemCount: weather.length,
        itemBuilder: (BuildContext context, int position) {
          return GestureDetector(
            onTap: () {
                     
                       weatherProvider.fetchWeather(weather[position].lable);
           
                     mydbrovider.con(weathermodel( id:weather[position].id, lable: weather[position].lable ));
                   Navigator.of(context).pop();
                        },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
          Dismissible(
           key: UniqueKey(),
                            onDismissed: (DismissDirection inm)async {
          
          await cur.delete(weathermodel(id: weather[position].id, lable: weather[position].lable ));
          
                             },
                               background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete),
                            ),
            child:  Container(
              alignment: Alignment.center,
                          width:MediaQuery.of(context).size.width ,
                          height: MediaQuery.of(context).size.height * 0.25,
                            child: ListTile(
                              title: Stack(
                                alignment: Alignment.center,
                                
                                children:[
          
          TweenFavorite( 300),
                     
                                 Text('${weather[position].lable}' , style: TextStyle(fontSize: 25),),
                              
                   
                              
                              ]),
                             
                        
                              ),
                            ),
          
                        ),
                                     mode == Orientation.portrait ?
                                     Container()
                                     :SizedBox(height: 60,),
                              Container(
                        margin: EdgeInsets.symmetric(horizontal: size.height / 18),
                        width: size.width * 1.2,
                        color: Colors.black,
                        height:1,
                      ),
              ],
            ),
          );

     
        },
      );}
    );
  }


TweenFavorite( double scale){

return TweenAnimationBuilder<double>(
       
          tween: Tween(begin:0.2 , end: 0.5 ), 
          duration:Duration(seconds: 10) ,
          builder: (_, double t , child)=>
          Transform.scale(
               alignment: Alignment.center,
            scale: t,
          child:Icon(Icons.favorite, color: Colors.red.shade50,size: scale,) ,) );

}



}
