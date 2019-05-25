import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyClouds,
  lightClouds,
  clear,
  unknown
}

@JsonSerializable()
class Weather extends Equatable {
  @JsonKey(name: 'weather_state_abbr')
  final String conditionAbbreviation;

  @JsonKey(name: 'the_temp')
  final double currentTemperature;

  @JsonKey(name: 'min_temp')
  final double minTemperature;

  @JsonKey(name: 'max_temp')
  final double maxTemperature;

  @JsonKey(name: 'applicable_date')
  final DateTime date;

  Weather({
    this.conditionAbbreviation,
    this.currentTemperature,
    this.minTemperature,
    this.maxTemperature,
    this.date,
  }) : super([
          conditionAbbreviation,
          currentTemperature,
          minTemperature,
          maxTemperature,
          date
        ]);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  WeatherCondition get condition {
    switch (conditionAbbreviation) {
      case 'sn':
        return WeatherCondition.snow;
      case 'sl':
        return WeatherCondition.sleet;
      case 'h':
        return WeatherCondition.hail;
      case 't':
        return WeatherCondition.thunderstorm;
      case 'hr':
        return WeatherCondition.heavyRain;
      case 'lr':
        return WeatherCondition.lightRain;
      case 's':
        return WeatherCondition.showers;
      case 'hc':
        return WeatherCondition.heavyClouds;
      case 'lc':
        return WeatherCondition.lightClouds;
      case 'c':
        return WeatherCondition.clear;
      default:
        return WeatherCondition.unknown;
    }
  }

  String get conditionAsString {
    switch (conditionAbbreviation) {
      case 'sn':
        return "Snow";
      case 'sl':
        return "Sleet";
      case 'h':
        return "Hail";
      case 't':
        return "Thunderstorm";
      case 'hr':
        return "Heavy Rain";
      case 'lr':
        return "Light Rain";
      case 's':
        return "Showers";
      case 'hc':
        return "Heavy Clouds";
      case 'lc':
        return "Light Clouds";
      case 'c':
        return "Clear";
      default:
        return "Unknown";
    }
  }
}
