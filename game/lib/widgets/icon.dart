import 'package:flutter/cupertino.dart';
import 'package:life_on_moon/palette.dart';

class GameIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onClick;

  GameIcon({ this.icon, this.selected, this.onClick });

  @override
  Widget build(_) {
    return Listener(
        onPointerUp: (_) => onClick(),
        child: Container(
            width: 40,
            height: 40,
            child: Icon(
                icon,
                color: selected ? Palette.WHITE : Palette.PASTEL_LIGHT_BLUE,
            ),
        ),
    );
  }
}
