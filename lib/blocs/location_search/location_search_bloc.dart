import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:weather_app/blocs/location_search/location_search_event.dart';
import 'package:weather_app/blocs/location_search/location_search_state.dart';
import 'package:weather_app/services/weather_api.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  static const LOCATION_SEARCH_DEBOUNCE_TIME = 500;

  final WeatherApi weatherApi = WeatherApi();

  @override
  LocationSearchState get initialState => LocationsEmpty();

  @override
  Stream<LocationSearchState> transform(
    Stream<LocationSearchEvent> events,
    Stream<LocationSearchState> Function(LocationSearchEvent event) next,
  ) {
    final suggestionsFetchObservable = Observable(events)
        .where(
          (LocationSearchEvent event) => event is FetchLocationsSuggestions,
        )
        .debounceTime(
          Duration(milliseconds: LOCATION_SEARCH_DEBOUNCE_TIME),
        );

    final otherLocationEventsObservable = Observable(events).where(
      (LocationSearchEvent event) => !(event is FetchLocationsSuggestions),
    );

    return super.transform(
      Observable.merge([
        suggestionsFetchObservable,
        otherLocationEventsObservable,
      ]),
      next,
    );
  }

  @override
  Stream<LocationSearchState> mapEventToState(
    LocationSearchEvent event,
  ) async* {
    if (event is FetchLocations) {
      try {
        yield LocationsLoading(locations: currentState.locations);

        final locations = await weatherApi.getLocationsBySearchTerm(
          event.searchTerm,
        );

        yield LocationsLoaded(locations: locations);
      } catch (error) {
        yield LocationsError(
          error: "Something went wrong. Please try again later.",
        );
      }
    }

    if (event is ResetLocations) {
      yield LocationsEmpty();
    }
  }
}
