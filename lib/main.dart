import 'package:flutter/material.dart';
import 'package:weather_app/splash_screen.dart';

import 'home_page.dart';

void main()=>runApp(WeatherApp());

class WeatherApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


