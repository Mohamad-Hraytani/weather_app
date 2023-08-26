import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providres/weather_provider.dart';



class Settings extends StatefulWidget {


  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.transparent,

body: Center(
  child:   Row(
    children: [
      Text("celsius" , style: TextStyle(color: Colors.white),),
          Switch(

        value: value, onChanged: (va){
      
      Provider.of<WeatherProvider>(context,listen: false).toggleTemperatureUnit();
      setState(() {
        value=va;
      });
      
      
      }),  Text("fahrenheit",  style: TextStyle(color: Colors.blue.shade200),),
    ],
  ),
),

    );
  }
}