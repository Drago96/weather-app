import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/types/typedef.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';

class GeographicForecast extends StatefulWidget {
  final LatLng coordinates;

  GeographicForecast({Key key, @required this.coordinates})
      : assert(coordinates != null),
        super(key: key);

  @override
  State<GeographicForecast> createState() => _GeographicForecastState();
}

class _GeographicForecastState extends State<GeographicForecast> {
  final _weatherForecastBloc = WeatherForecastBloc();

  FetchWeatherForecastCallback _fetchWeatherForecastByCoordinates(
    latitude,
    longitude,
  ) {
    return (BuildContext context) {
      _weatherForecastBloc.dispatch(FetchWeatherForecastByLocationCoordiantes(
        latitude: latitude,
        longitude: longitude,
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _weatherForecastBloc,
      child: WeatherForecastContainer(
        fetchWeatherForecast: _fetchWeatherForecastByCoordinates(
          widget.coordinates.latitude,
          widget.coordinates.longitude,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _weatherForecastBloc.dispose();

    super.dispose();
  }
}
