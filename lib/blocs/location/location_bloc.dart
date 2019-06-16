import 'package:bloc/bloc.dart';

import 'package:weather_app/blocs/location/location_event.dart';
import 'package:weather_app/blocs/location/location_state.dart';
import 'package:weather_app/services/weather_api.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final WeatherApi weatherApi = WeatherApi();

  @override
  LocationState get initialState => LocationEmpty();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchLocationByCoordinates) {
      try {
        yield LocationLoading();

        final location = await weatherApi.getLocationByCoordinates(
          event.latitude,
          event.longitude,
        );

        yield LocationLoaded(location: location);
      } catch (error) {
        yield LocationError(
          error: "There was an error while finding location",
        );
      }
    }

    if (event is ResetLocation) {
      yield LocationEmpty();
    }
  }
}
