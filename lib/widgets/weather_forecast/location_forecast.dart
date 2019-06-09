import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/types/typedef.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';

class LocationForecast extends StatefulWidget {
  final Location location;

  LocationForecast({Key key, @required this.location})
      : assert(location != null),
        super(key: key);

  @override
  State<LocationForecast> createState() => _LocationForecastState();
}

class _LocationForecastState extends State<LocationForecast> {
  final _weatherForecastBloc = WeatherForecastBloc();

  FetchWeatherForecastCallback _fetchWeatherForecastByLocationId(locationId) {
    return (BuildContext context) {
      _weatherForecastBloc.dispatch(FetchWeatherForecastByLocationId(
        locationId: widget.location.id,
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _weatherForecastBloc,
      child: WeatherForecastContainer(
        fetchWeatherForecast:
            _fetchWeatherForecastByLocationId(widget.location.id),
      ),
    );
  }

  @override
  void dispose() {
    _weatherForecastBloc.dispose();

    super.dispose();
  }
}
