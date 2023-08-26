import 'package:flutter/material.dart';


class gradient extends StatelessWidget {
double temperature ;
   gradient({required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: MediaQuery.of(context).size.height,
          child: Align(
          alignment: Alignment.bottomCenter,
          child:   AnimatedContainer(
            duration: Duration(seconds: 2),
            height: MediaQuery.of(context).size.height *0.75,
            decoration: BoxDecoration(gradient: LinearGradient(
          
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.01,0.2,1],
            colors:temperature<23? [
          Color(0xFF79E3EC) ,Color(0xFF2187FF) , Colors.transparent 
          
          
          
          ]:temperature<25 && temperature >23 ?[
           Color(0xFF2187FF) ,Color(0xFF8B80F8) , Colors.transparent 
          
          
          
          ]:temperature<27 && temperature >25 ?[ Color(0xFF8B80F8) ,Color(0xFFFF9B91) , Colors.transparent ]:
           
          
          [
           Color(0xFFFF9B91) ,Color(0xFFFF4593) , Colors.transparent
          
          
          ])),),
          ),
        );
  }
}