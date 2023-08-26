import 'package:flutter/material.dart';

class bottombar extends StatelessWidget {
double temperature ;
   bottombar({required this.temperature});

  @override
  Widget build(BuildContext context) {
    return   Container(
              height: MediaQuery.of(context).size.height,
          child: Align(
          
          alignment: Alignment.bottomCenter,
          child:  
            AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: 1,
            child: 
            Container(
           decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(
            temperature<23? "assets/mountain1.png":temperature<25 && temperature >23 ?"assets/mountain2.png":temperature<27 && temperature >25 ?"assets/mountain3.png":"assets/mountain4.png"
            ),fit: BoxFit.fill)),
          
            ), 
          ),
          ),
        );
    
  }
}