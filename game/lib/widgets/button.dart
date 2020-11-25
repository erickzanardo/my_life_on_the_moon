import 'package:flutter/material.dart';
import 'package:life_on_moon/palette.dart';
import 'package:life_on_moon/widgets/label.dart';

class GameButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;

  GameButton({ this.onPress, this.label });

  @override
  Widget build(_) {
    return Listener(
        onPointerUp: (_) => onPress(),
        child: Container(
            height: 40,
            color: Palette.PASTEL_BLUE,
            child: Center(child: GameLabel(label)),
        ),
    );
  }
}
