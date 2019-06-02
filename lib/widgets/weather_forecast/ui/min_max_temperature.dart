import 'package:flutter/material.dart';

class MinMaxTemperature extends StatelessWidget {
  final double minTemperature;
  final double maxTemperature;
  final double fontSize;

  MinMaxTemperature({
    @required this.minTemperature,
    @required this.maxTemperature,
    this.fontSize = 30,
  }) : assert(minTemperature != null, maxTemperature != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${maxTemperature.round()}°/${minTemperature.round()}°",
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
