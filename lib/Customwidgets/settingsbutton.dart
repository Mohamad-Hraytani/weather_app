import 'package:flutter/material.dart';

class settingsbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      var mode = MediaQuery.of(context).orientation; 
    return  Container(    height: MediaQuery.of(context).size.height,
            child: Builder(
              builder: (context) {
                return Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                     width:mode == Orientation.portrait ?  75:65,
            height:mode == Orientation.portrait ? 60:50,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
            child: IconButton(icon: Icon(Icons.settings ,color: Colors.black,), onPressed: () {
                  
                  Scaffold.of(context).openDrawer();
                  },),
            ));
              }
            ),
          );
  }
}