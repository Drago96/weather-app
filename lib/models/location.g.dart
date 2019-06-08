// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(id: json['woeid'] as int, name: json['title'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) =>
    <String, dynamic>{'title': instance.name, 'woeid': instance.id};
