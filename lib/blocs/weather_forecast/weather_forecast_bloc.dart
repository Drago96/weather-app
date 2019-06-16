import 'package:bloc/bloc.dart';

import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_state.dart';

class WeatherForecastBloc
    extends Bloc<WeatherForecastEvent, WeatherForecastState> {
  final WeatherApi _weatherApi = WeatherApi();

  @override
  WeatherForecastState get initialState => WeatherForecastEmpty();

  @override
  Stream<WeatherForecastState> mapEventToState(
    WeatherForecastEvent event,
  ) async* {
    if (event is FetchWeatherForecastEvent) {
      yield* _fetchWeatherForecast(event);
    }

    if (event is SetWeatherForecast) {
      yield WeatherForecastLoaded(weatherForecast: event.weatherForecast);
    }

    if (event is SetWeatherForecastError) {
      yield _weatherForecastError(event.error);
    }
  }

  Stream<WeatherForecastState> _fetchWeatherForecast(
    WeatherForecastEvent event,
  ) async* {
    try {
      WeatherForecast weatherForecast;

      if (event is FetchWeatherForecastByLocationCoordiantes) {
        weatherForecast =
            await _weatherApi.getWeatherForecastByLocationCoordinates(
          event.latitude,
          event.longitude,
        );
      }

      if (event is FetchWeatherForecastByLocationId) {
        weatherForecast =
            await _weatherApi.getWeatherForecastByLocationId(event.locationId);
      }

      yield WeatherForecastLoaded(weatherForecast: weatherForecast);
    } catch (error) {
      yield _weatherForecastError(
        "Something went wrong. Please try again later.",
      );
    }
  }

  WeatherForecastError _weatherForecastError(String error) =>
      WeatherForecastError(
        error: error,
        weatherForecast: currentState.weatherForecast,
      );
}
