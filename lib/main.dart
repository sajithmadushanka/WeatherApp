import 'package:flutter/material.dart';
import 'package:weatherapp/currentWeather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatheApp',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const CurrentWeather(),
    );
  }
}

