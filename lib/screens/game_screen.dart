import 'package:flutter/material.dart';

import '../game/game.dart';

class MoonGameScreen extends StatelessWidget {
  @override
  Widget build(_) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (_, contrainsts) {
              final size = Size(contrainsts.maxWidth, contrainsts.maxWidth);
              return MoonGame(size).widget;
            }
        ),
    );
  }
}
