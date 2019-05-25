import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  final Widget child;

  ScrollableContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverFillRemaining(
          child: Container(
            child: child,
          ),
        )
      ],
    );
  }
}
