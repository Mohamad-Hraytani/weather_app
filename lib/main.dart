import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Providres/SQL/mySqdb_provider.dart';
import 'package:weather_app/Screens/Favorite.dart';

import 'Screens/Home_screen.dart';
import 'Providres/weather_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  mySqdb mydb = mySqdb();
  mydb.weatherdata();

  runApp(MyApp());
} 

  
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[ 
  
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
       child: HomeScreen()
      ),
   ChangeNotifierProvider(
      create: (context) => mySqdb(),
      
       child: Favorite())


        ],
    
    
    
  
      child: MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
