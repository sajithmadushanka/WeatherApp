import 'package:flutter/material.dart';
import 'package:weatherapp/currentWeather.dart';
import 'package:device_preview/device_preview.dart';
void main() {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) =>const MyApp())
);
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

