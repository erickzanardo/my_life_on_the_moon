import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:life_on_moon/palette.dart';
import 'package:life_on_moon/widgets/label.dart';

class GameButton extends HookWidget {
  final String label;
  final VoidCallback onPress;

  GameButton({ this.onPress, this.label });

  @override
  Widget build(_) {
    final pressed = useState(false);

    return Listener(
        onPointerDown: (_) {
          pressed.value = true;
        },
        onPointerUp: (_) {
          pressed.value = false;
          onPress();
        },
        child: Container(
            height: 40,
            color: pressed.value ? Palette.PASTEL_DARK_BLUE : Palette.PASTEL_BLUE,
            child: Center(child: GameLabel(label)),
        ),
    );
  }
}
