// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
      conditionAbbreviation: json['weather_state_abbr'] as String,
      currentTemperature: (json['the_temp'] as num)?.toDouble(),
      minTemperature: (json['min_temp'] as num)?.toDouble(),
      maxTemperature: (json['max_temp'] as num)?.toDouble(),
      date: json['applicable_date'] == null
          ? null
          : DateTime.parse(json['applicable_date'] as String));
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'weather_state_abbr': instance.conditionAbbreviation,
      'the_temp': instance.currentTemperature,
      'min_temp': instance.minTemperature,
      'max_temp': instance.maxTemperature,
      'applicable_date': Weather._applicableDateToJson(instance.date)
    };
