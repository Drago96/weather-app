import 'package:flutter/material.dart';

class WeatherRow extends StatelessWidget {
  final List<Widget> children;

  const WeatherRow({@required this.children}) : assert(children != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
