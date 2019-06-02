import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';

class ConditionIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double scale;

  ConditionIcon({
    @required this.condition,
    this.scale = 1,
  }) : assert(condition != null);

  String _getConditionImageUrl() {
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightClouds:
      case WeatherCondition.unknown:
        return 'assets/clear.png';
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return 'assets/snow.png';
      case WeatherCondition.heavyClouds:
        return 'assets/cloudy.png';
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return 'assets/rainy.png';
      case WeatherCondition.thunderstorm:
        return 'assets/thunderstorm.png';
      default:
        return 'assets/clear.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _getConditionImageUrl(),
      scale: scale,
    );
  }
}
