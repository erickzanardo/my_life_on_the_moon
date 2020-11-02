import 'package:flame/components/component.dart';
import 'package:flame/text_config.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';

import 'state_fourth_dimension.dart';
import 'stations/stations.dart';

class GameState with StateFourthDimension {
  List<Station> stations = [
    Station(position: Vector2(1, 0)),
    Station(position: Vector2(0, 0)),
    Station(position: Vector2(-1, 0)),
  ];
}

class GameStateComponent extends Component {

  static final label = TextConfig(
      color: Color(0xFFFFFFFF),
      fontSize: 20,
  );

  GameState state;

  GameStateComponent(this.state);

  @override
  void render(Canvas canvas) {
    label.render(
        canvas,
        "Earth days: ${state.pastEarthDays} Lunar days: ${state.pastLunarDays}",
        Vector2(10, 10),
    );
    label.render(
        canvas,
        "(Current) Earth day ${state.earthDayProgress.toStringAsFixed(2)} Lunar day: ${state.lunarDayProgress.toStringAsFixed(2)}",
        Vector2(10, 30),
    );
    label.render(
        canvas,
        "Daytime ${state.daytime}",
        Vector2(10, 50),
    );
    label.render(
        canvas,
        "Speed factor ${state.speed}",
        Vector2(10, 70),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    state.update(dt);
  }

  @override
  int priority() => 10;
}
