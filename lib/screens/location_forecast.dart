import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/types/typedef.dart';
import 'package:weather_app/blocs/weather_forecast/weather_forecast_event.dart';
import 'package:weather_app/widgets/weather_forecast/weather_forecast_container.dart';

class LocationForecastArguments {
  final Location location;

  LocationForecastArguments({@required this.location})
      : assert(location != null);
}

class LocationForecast extends StatefulWidget {
  static const routeName = '/location_forecast';

  LocationForecast({Key key}) : super(key: key);

  @override
  State<LocationForecast> createState() => _LocationForecastState();
}

class _LocationForecastState extends State<LocationForecast> {
  final weatherForecastBloc = WeatherForecastBloc();

  FetchWeatherForecastCallback _fetchWeatherForecastByLocationId(locationId) {
    return (BuildContext context) {
      weatherForecastBloc.dispatch(FetchWeatherForecastByLocationId(
        locationId: locationId,
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    final LocationForecastArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.location.name),
      ),
      body: BlocProvider(
        bloc: weatherForecastBloc,
        child: WeatherForecastContainer(
          fetchWeatherForecast:
              _fetchWeatherForecastByLocationId(args.location.id),
        ),
      ),
    );
  }

  @override
  void dispose() {
    weatherForecastBloc.dispose();

    super.dispose();
  }
}
