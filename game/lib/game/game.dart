import 'package:flame/game.dart';
import 'package:flame/extensions/size.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';
import 'dart:math';

import 'widgets/speed_control_overlay.dart';

import 'game_state/game_state.dart';
import 'game_state/resources.dart';

import 'components/game_state_component.dart';
import 'components/daytime_background.dart';
import 'components/stations/stations_component.dart';

import 'game_state/stations/stations.dart';
import 'game_state/people_manager.dart';

class MoonGame extends BaseGame with HasWidgetsOverlay {
  static final gameSize = Vector2(800, 600);
  static final _clipRect = Rect.fromLTWH(0, 0, gameSize.x, gameSize.y);

  GameState state;
  double _scaleFactor;
  Vector2 _gameOffset;

  MoonGame(Size screenSize) {
    size.setFrom(screenSize.toVector2());
    state = GameState()..resources = (Resources()..water = 20);

    // Mock data
    state.stations.addAll([
      CommandCenter(position: Vector2(-2, 0), id: 1),
      SolarPanel(position: Vector2(1, 0), id: 2),
      SolarPanel(position: Vector2(0, 0), id: 2),
      BatteryRoom(position: Vector2(-1, 0), id: 3),
      Barracks(position: Vector2(-1, -1), id: 4),
      Farm(position: Vector2(-1, -2), id: 5),
      WaterMine(position: Vector2(2, 0), id: 6),
      ConcreteFactory(position: Vector2(0, 0), id: 7),
    ]);

    state.people.addAll([
      Person()
        ..name = 'John'
        ..age = 30
        ..workingStationId = 5,
      Person()
        ..name = 'Neo'
        ..age = 28
        ..workingStationId = 5,
      Person()
        ..name = 'Constantine'
        ..age = 22
        ..workingStationId = 6,
      Person()
        ..name = 'Klaatu'
        ..age = 20
        ..workingStationId = 7,
    ]);

    state.resources.food = 10;

    // This probably can't be here when we have saved games and stuff
    state.onDayBegin(state);

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
      // Stations
      images.load('stations/command_center.png'),
      images.load('stations/battery_room.png'),
    ]);

    // this can be loaded from a saved game eventually
    add(GameStateComponent());
    add(DaytimeBackground());
    add(StationsComponent());

    addWidgetOverlay('SpeedControlOverlay', SpeedControlOverlay(this));
  }

  @override
  void onResize(size) {
    super.onResize(size);
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
