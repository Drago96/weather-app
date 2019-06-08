import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  final DateTime date;

  Date({@required this.date}) : assert(date != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.MMMd().format(date),
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
