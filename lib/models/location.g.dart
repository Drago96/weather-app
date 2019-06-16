// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      name: json['title'] as String,
      id: json['woeid'] as int,
      lattLong: json['latt_long'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'title': instance.name,
      'woeid': instance.id,
      'latt_long': instance.lattLong
    };
