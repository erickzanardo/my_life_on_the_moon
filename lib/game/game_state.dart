import 'package:flame/components/component.dart';
import 'package:flame/text_config.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';

const EARTH_DAY_DURATION = 120; // secs (2 minutes)
const LUNAR_DAY_DURATION = EARTH_DAY_DURATION * 27;

class GameState {
  int pastEarthDays = 0;
  int pastLunarDays = 0;

  double currentEarthDay = 0.0;
  double currentLunarDay = 0.0;

  int _speed = 9;

  void pauseSpeed() {
    _speed = 0;
  }

  void normalSpeed() {
    _speed = 1;
  }

  void fastSpeed() {
    _speed = 3;
  }

  void superFastSpeed() {
    _speed = 9;
  }


  void update(double dt)  {
    double _dt = dt * _speed;

    currentLunarDay += _dt;
    currentEarthDay += _dt;

    if (currentEarthDay >= EARTH_DAY_DURATION) {
      pastEarthDays++;
      currentEarthDay -= EARTH_DAY_DURATION;
    }

    if (currentLunarDay >= LUNAR_DAY_DURATION) {
      pastLunarDays++;
      currentLunarDay -= LUNAR_DAY_DURATION;
    }
  }

  get earthDayProgress => currentEarthDay / EARTH_DAY_DURATION;
  get lunarDayProgress => currentLunarDay / LUNAR_DAY_DURATION;
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
        "Speed factor ${state._speed}",
        Vector2(10, 50),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    state.update(dt);
  }
}
