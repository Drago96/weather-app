import 'package:flutter/material.dart';

import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/weather_forecast/ui/condition_icon.dart';
import 'package:weather_app/widgets/weather_forecast/ui/min_max_temperature.dart';
import 'package:weather_app/widgets/weather_forecast/ui/date.dart';

class DailyWeatherForecast extends StatelessWidget {
  final List<Weather> consolidatedWeather;

  DailyWeatherForecast({@required this.consolidatedWeather})
      : assert(consolidatedWeather != null);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(
        top: 25.0,
        bottom: 25.0,
        left: 10,
        right: 10,
      ),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, index) {
        return VerticalDivider(
          color: Colors.black,
        );
      },
      itemCount: consolidatedWeather.length,
      itemBuilder: (_, index) {
        final weather = consolidatedWeather.elementAt(index);

        return Padding(
          padding: EdgeInsets.only(left: 7.0, right: 7.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Date(
                  date: weather.date,
                ),
                SizedBox(
                  height: 20,
                ),
                ConditionIcon(
                  condition: weather.condition,
                  scale: 1.5,
                ),
                SizedBox(
                  height: 20,
                ),
                MinMaxTemperature(
                  maxTemperature: weather.maxTemperature,
                  minTemperature: weather.minTemperature,
                  fontSize: 20,
                ),
              ]),
        );
      },
    );
  }
}
