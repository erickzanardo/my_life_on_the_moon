import 'package:flame/game.dart';
import 'package:flame/extensions/size.dart';

import 'dart:ui';

import 'game_state.dart';

class MoonGame extends BaseGame {

  GameState state;

  MoonGame(Size screenSize) {
    size = screenSize.toVector2();

    // this can be loaded from a saved game eventually
    add(GameStateComponent(state = GameState()));
  }
}
