
import 'package:flutter/cupertino.dart';
import 'package:life_on_moon/palette.dart';

class GameLabel extends StatelessWidget {

  final String label;

  GameLabel(this.label);

  @override
  Widget build(_) {
    return Text(
        label,
        style: TextStyle(
            color: Palette.PASTEL_LIGHT_BLUE,
            fontSize: 16,
        ),
    );
  }
}
