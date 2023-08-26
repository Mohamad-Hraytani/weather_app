import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app/Screens/Forcast.dart';
import 'package:weather_app/Screens/Home_screen.dart';

class forecastbutton extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
      var mode = MediaQuery.of(context).orientation; 
    return Container(    height: MediaQuery.of(context).size.height,
          child: Align(
          alignment: Alignment(0 , 0.88),
          child: Container(
            width:mode == Orientation.portrait ? 65 : 45,
            height: mode == Orientation.portrait ? 65 : 45,
            decoration: BoxDecoration(
            color: Color(0xFF253F5D) ,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
        BoxShadow(color: Colors.white  ,blurRadius: 20)]
            ),
            child: IconButton(icon: Icon(Icons.assessment_outlined ,color: Colors.white.withOpacity(0.5),size:mode == Orientation.portrait ? 40 : 30,), onPressed: () {  

         Navigator.push(
                            context,
                            PageTransition(
                              ctx: context,
                              duration: Duration(seconds: 2),
                              child: forecast(),
                              type: PageTransitionType.theme,
                              childCurrent: HomeScreen(),
                              reverseDuration: Duration(seconds: 2),
                            ));


            },),
            )),
        );
  }
}