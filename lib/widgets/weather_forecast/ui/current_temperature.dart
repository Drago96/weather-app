import 'package:flutter/material.dart';

class CurrentTemperature extends StatelessWidget {
  final double currentTemperature;

  CurrentTemperature({@required this.currentTemperature})
      : assert(currentTemperature != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${currentTemperature.round()}°",
      style: TextStyle(
        fontSize: 50,
        color: Colors.white,
      ),
    );
  }
}
