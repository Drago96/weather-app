import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GradientContainer extends StatelessWidget {
  final MaterialColor color;
  final Widget child;

  const GradientContainer({@required this.color, @required this.child})
      : assert(color != null, child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.6, 0.8, 1.0],
          colors: [
            color[700],
            color[500],
            color[300],
          ],
        ),
      ),
      child: child,
    );
  }
}
