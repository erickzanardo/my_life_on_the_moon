import 'package:flame/game.dart';
import 'package:flame/extensions/size.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';
import 'dart:math';

import 'game_state/game_state.dart';
import 'game_state/resources.dart';

import 'components/game_state_component.dart';
import 'components/daytime_background.dart';
import 'components/stations_component.dart';

import 'game_state/stations/stations.dart';
import 'game_state/people_manager.dart';

class MoonGame extends BaseGame {

  static final gameSize = Vector2(800, 600);
  static final _clipRect = Rect.fromLTWH(0, 0, gameSize.x, gameSize.y);

  GameState state;
  double _scaleFactor;
  Vector2 _gameOffset;

  MoonGame(Size screenSize) {
    size = screenSize.toVector2();
    state = GameState()
        ..resources = (
            Resources()
            ..water = 20
        );

    // Mock data
    state.stations.addAll([
      CommandCenter(position: Vector2(-2, 0), id: 1),
      SolarPanel(position: Vector2(1, 0), id: 2),
      SolarPanel(position: Vector2(0, 0), id: 2),
      BatteryRoom(position: Vector2(-1, 0), id: 3),
      Barracks(position: Vector2(-1, -1), id: 4),
      Farm(position: Vector2(-1, -2), id: 5),
    ]);

    state.people.addAll([
      Person()
        ..name = 'John'
        ..age = 30
        ..workingStationId = 5
    ]);

    state.resources.food = 10;

    calcBoundaries();
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
  Future<void> onLoad() async {
    await Future.wait([
      images.load('earth.png'),
      images.load('sun.png'),
    ]);

    // this can be loaded from a saved game eventually
    add(GameStateComponent());
    add(DaytimeBackground());
    add(StationsComponent());
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
