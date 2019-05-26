import 'package:flutter/material.dart';

import 'package:weather_app/blocs/weather_forecast/weather_forecast_bloc.dart';

class WeatherForecastBlocProvider extends InheritedWidget {
  final WeatherForecastBloc bloc = WeatherForecastBloc();

  WeatherForecastBlocProvider({Key key, @required Widget child})
      : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static WeatherForecastBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(WeatherForecastBlocProvider)
            as WeatherForecastBlocProvider)
        .bloc;
  }
}
