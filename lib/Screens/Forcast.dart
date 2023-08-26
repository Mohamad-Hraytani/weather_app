import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Providres/weather_provider.dart';



class forecast extends StatelessWidget {

late List<dynamic> forecastList;

  @override
  Widget build(BuildContext context) {

    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weatherData = weatherProvider.forecastData;

    forecastList = weatherData['list'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height:  MediaQuery.of(context).size .height,
          decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
 
Colors.white, Colors.blue.shade300,

          ]
          )),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            
          SizedBox(height: 30),
            
          Text(
            '${weatherProvider.City_name} 5-Day Forecast',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
            

            
          Container(
             height:  MediaQuery.of(context).size .height *0.81,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: forecastList.length,
              itemBuilder: (context, index) {
                
                final forecast = forecastList[index];
                final forecastTime = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
                final temperature = forecast['main']['temp'];
                final description = forecast['weather'][0]['description'];
              
                return ListTile(
                  leading: Text(
                    '${forecastTime.hour}:00',
                    style: TextStyle(fontSize: 16),
                  ),
                  title: Text(
                    '$temperature°C - $description',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          ],
            ),
        ),
      ),
    );
  }
}