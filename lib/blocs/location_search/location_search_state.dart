import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:weather_app/models/location.dart';

@immutable
abstract class LocationSearchState extends Equatable {
  final List<Location> locations;

  LocationSearchState(this.locations, [List props = const []]) : super([props]);
}

class LocationsEmpty extends LocationSearchState {
  LocationsEmpty() : super([]);
}

class LocationsLoading extends LocationSearchState {
  LocationsLoading({List<Location> locations}) : super(locations);
}

class LocationsLoaded extends LocationSearchState {
  LocationsLoaded({@required List<Location> locations})
      : assert(locations != null),
        super(locations);
}

class LocationsError extends LocationSearchState {
  final String error;

  LocationsError({this.error}) : super([], [error]);
}
