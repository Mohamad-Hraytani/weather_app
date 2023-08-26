import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providres/SQL/mySqdb_provider.dart';
import 'package:weather_app/Providres/SQL/weathermodel.dart';
import 'package:weather_app/Providres/weather_provider.dart';
import 'package:weather_app/Screens/Favorite.dart';
import 'package:weather_app/Screens/Home_screen.dart';


class favoritebutton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final weatherProvider = Provider.of<WeatherProvider>(context );
  var mode = MediaQuery.of(context).orientation; 
    return         Container(    height: MediaQuery.of(context).size.height,
          child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width:mode == Orientation.portrait ?  75:65,
            height:mode == Orientation.portrait ? 60:45,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
            child: IconButton(icon: Icon(Icons.favorite ,color: Colors.black,size: 30,), onPressed: () {
           Provider.of<mySqdb>(context , listen: false ).con(weathermodel( id:weatherProvider.id, lable: weatherProvider.City_name ));
          
           Navigator.push(
                                      context,
                                      PageTransition(
                                        ctx: context,
                                        duration: Duration(seconds: 2),
                                        child: Favorite(),
                                        type: PageTransitionType.theme,
                                        childCurrent: HomeScreen(),
                                        reverseDuration: Duration(seconds: 2),
                                      ));
          },),
            ),),
        );
  }
}