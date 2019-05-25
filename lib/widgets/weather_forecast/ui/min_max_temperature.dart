import 'package:flutter/material.dart';

class MinMaxTemperature extends StatelessWidget {
  final double minTemperature;
  final double maxTemperature;

  MinMaxTemperature({@required this.minTemperature, @required this.maxTemperature})
      : assert(minTemperature != null, maxTemperature != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${maxTemperature.round()}°/${minTemperature.round()}°",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
