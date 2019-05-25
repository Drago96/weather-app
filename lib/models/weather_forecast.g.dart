// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForecast _$WeatherForecastFromJson(Map<String, dynamic> json) {
  return WeatherForecast(
      locationName: json['title'] as String,
      locationId: json['woeid'] as int,
      updatedAt:
          WeatherForecast._updatedAtFromJson(json['updated_at'] as DateTime),
      consolidatedWeather: (json['consolidated_weather'] as List)
          ?.map((e) =>
              e == null ? null : Weather.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$WeatherForecastToJson(WeatherForecast instance) =>
    <String, dynamic>{
      'title': instance.locationName,
      'woeid': instance.locationId,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'consolidated_weather': instance.consolidatedWeather
    };
