import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  @JsonKey(name: 'title')
  final String name;

  @JsonKey(name: 'woeid')
  final int id;

  @JsonKey(name: 'latt_long')
  final String lattLong;

  Location({
    this.name,
    this.id,
    this.lattLong,
  }) : super([name, id, lattLong]);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  double get latitude => double.parse(lattLong.split(',').first);

  double get longitude => double.parse(lattLong.split(',').last);
}
