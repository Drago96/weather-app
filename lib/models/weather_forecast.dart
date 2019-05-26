import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:weather_app/models/weather.dart';

part 'weather_forecast.g.dart';

@JsonSerializable()
class WeatherForecast extends Equatable {
  @JsonKey(name: 'title')
  final String locationName;

  @JsonKey(name: 'woeid')
  final int locationId;

  @JsonKey(name: 'updated_at', fromJson: _updatedAtFromJson)
  final DateTime updatedAt;

  @JsonKey(name: 'consolidated_weather')
  final List<Weather> consolidatedWeather;

  WeatherForecast(
      {this.locationName,
      this.locationId,
      this.updatedAt,
      this.consolidatedWeather})
      : super([locationName, locationId, updatedAt, consolidatedWeather]);

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastToJson(this);

  Weather get currentWeather => consolidatedWeather.first;

  static DateTime _updatedAtFromJson(String updatedAtJsonValue) =>
      updatedAtJsonValue != null
          ? DateTime.parse(updatedAtJsonValue)
          : DateTime.now();
}
