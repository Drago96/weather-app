import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const []]) : super(props);
}

class FetchLocationByCoordinates extends LocationEvent {
  final double latitude;
  final double longitude;

  FetchLocationByCoordinates({
    @required this.latitude,
    @required this.longitude,
  })  : assert(latitude != null, longitude != null),
        super([latitude, longitude]);
}

class ResetLocation extends LocationEvent {}
