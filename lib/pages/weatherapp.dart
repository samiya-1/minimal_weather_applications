import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_applications/models/weathermodel.dart';
import 'package:minimal_weather_applications/services/weatherservice.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  //api key

  final _weatherService = WeatherServices("c6cd0917fa73e822a0bb9fc603e795ca");
  WeatherModel? _weatherModel;

  //fetch weather
  _fetchWeather() async {
    //get current city weather
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city

    try {
      final weatherModel = await _weatherService.getWeather(cityName);
      setState(() {
        _weatherModel = weatherModel;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null)
      return 'assets/animation/Animation - 1719564018260.json';
    switch (mainCondition.toLowerCase()) {
      case 'rain':
        return "assets/animation/Animation - 1719564046233.json";
      case 'rain':
        return "assets/animation/Animation - 1719564077343.json";

      case 'rain':
        return "assets/animation/Animation - 1719564110975.json";
      default:
        return 'assets/animation/Animation - 1719564018260.json';
    }
  }



  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weatherModel?.cityName ?? "Loading city..",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Lottie.asset(getWeatherAnimation(_weatherModel?.mainCondition)),
            Text(
              '${_weatherModel?.temperature.round()} °',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Text(
              _weatherModel?.mainCondition ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
