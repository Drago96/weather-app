import 'package:flutter/material.dart';
import 'package:weather_app/widgets/ui/gradient_container.dart';

class Weather extends StatelessWidget {
  Widget _appBar(BuildContext context) {
    return AppBar(
      title: Text('Weather'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.location_city),
          onPressed: () {
            Navigator.pushNamed(context, '/locations');
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Center(
        child: GradientContainer(
          child: Text('Hi'),
          color: Colors.amber,
        ),
      ),
    );
  }
}
