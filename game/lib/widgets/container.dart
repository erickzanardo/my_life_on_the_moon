import 'package:flutter/material.dart';
import 'package:life_on_moon/palette.dart';

class GameContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  GameContainer({
    this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(ctx) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Palette.PASTEL_DARK_BLUE,
            border: Border.all(
                color: Palette.PASTEL_BLUE,
                width: 10,
            ),
        ),
        child: child,
    );
  }
}
