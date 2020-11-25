import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GameClickable extends HookWidget {
  final Widget child;
  final VoidCallback onClick;

  GameClickable({ this.child, this.onClick });

  @override
  Widget build(_) {
    final pressed = useState(false);

    return Opacity(
        opacity: pressed.value ? 0.4 : 1,
        child: Listener(
            child: child,
            onPointerDown: (_) => pressed.value = true,
            onPointerUp:  (_) {
              pressed.value = false;
              onClick?.call();
            },
        ),
    );
  }
}
