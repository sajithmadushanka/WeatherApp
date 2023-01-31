import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final TextEditingController _controller = TextEditingController();
  String defalutCounty = 'Spain';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherApp'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              onSubmitted: (value) {
                setState(() {
                  defalutCounty = value;
                });
              },
              decoration: InputDecoration(
                  hintText: 'Search Country',
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12)),
                  fillColor: Colors.grey[200],
                  filled: true),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: FutureBuilder(
                future: getCurrentWeather(),
                builder: ((context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data != 'error' && snapshot.data != null) {
                    Weather weatherObj = snapshot.data;

                    return weatherBox(weatherObj);
                  } else if (snapshot.data == 'error') {
                    return const Text("errorr");
                  } else {
                    return const CircularProgressIndicator();
                  }
                })),
          ),
        ],
      ),
    );
  }
// show widget on screen 
  Widget weatherBox(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${(weather.temp! - 273.15).toStringAsFixed(2)}°C',
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text('${weather.description}'),
        Text('feels ${(weather.feelsLike! - 273.15).toStringAsFixed(2)} °C'),
        Text(
            'H: ${(weather.high! - 273.15).toStringAsFixed(2)}°C  L: ${(weather.low! - 273.15).toStringAsFixed(2)}°C'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.amber,
            height: 50,
            width: 200,
            child: Center(
                child: Text(
              'temp of $defalutCounty',
              style: TextStyle(fontSize: 25.0),
            )),
          ),
        )
      ],
    );
  }
// future method for API handle 
  Future getCurrentWeather() async {
    Weather weather;
    String city = defalutCounty;
    String apikey = '01d47ad0693bd6610982580cda92f0bf';
    var url = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apikey");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      return weather;
    } else {
      return "error";
    }
  }
}
