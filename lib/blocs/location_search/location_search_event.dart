import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class LocationSearchEvent extends Equatable {
  LocationSearchEvent([List props = const []]) : super(props);
}

class FetchLocations extends LocationSearchEvent {
  final String searchTerm;

  FetchLocations({@required this.searchTerm})
      : assert(searchTerm != null),
        super([searchTerm]);
}

class FetchLocationsSuggestions extends FetchLocations {
  FetchLocationsSuggestions({@required String searchTerm})
      : super(searchTerm: searchTerm);
}

class ResetLocations extends LocationSearchEvent {}
