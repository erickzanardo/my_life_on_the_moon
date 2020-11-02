import 'package:flame/game.dart';
import 'package:flame/extensions/size.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';
import 'dart:math';

import 'game_state.dart';

import 'components/daytime_background.dart';

class MoonGame extends BaseGame {

  static final gameSize = Vector2(800, 600);
  static final _clipRect = Rect.fromLTWH(0, 0, gameSize.x, gameSize.y);

  GameState state;
  double _scaleFactor;
  Vector2 _gameOffset;

  MoonGame(Size screenSize) {
    size = screenSize.toVector2();

    calcBoundaries();

    // this can be loaded from a saved game eventually
    add(GameStateComponent(state = GameState()));
    add(DaytimeBackground());
  }

  void calcBoundaries() {
    final scaleRaw = min(size.y / gameSize.y, size.x / gameSize.x);
    _scaleFactor = scaleRaw - scaleRaw % 0.02;

    _gameOffset = Vector2(
        size.x / 2 - (gameSize.x * _scaleFactor) / 2,
        size.y / 2 - (gameSize.y * _scaleFactor) / 2,
    );

  }

  @override
  void resize(size) {
    super.resize(size);
    calcBoundaries();
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(_gameOffset.x, _gameOffset.y);
    canvas.scale(_scaleFactor, _scaleFactor);
    canvas.clipRect(_clipRect);
    super.render(canvas);
    canvas.restore();
  }
}
