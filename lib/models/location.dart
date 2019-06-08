import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  @JsonKey(name: 'title')
  final String name;

  @JsonKey(name: 'woeid')
  final int id;

  Location({
    this.name,
    this.id,
  }) : super([name, id]);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
