import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/location.dart';

@immutable
abstract class LocationState extends Equatable {
  LocationState([List props = const []]) : super([props]);
}

class LocationEmpty extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Location location;

  LocationLoaded({@required this.location})
      : assert(location != null),
        super([location]);
}

class LocationError extends LocationState {
  final String error;

  LocationError({this.error}) : super([error]);
}
