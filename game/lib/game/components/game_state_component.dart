import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/text_config.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';

import '../game.dart';

class GameStateComponent extends Component with HasGameRef<MoonGame> {

  static final label = TextConfig(
      color: Color(0xFFFFFFFF),
      fontSize: 20,
  );

  GameStateComponent();

  @override
  void render(Canvas canvas) {
    final state = gameRef.state;
    label.render(
        canvas,
        "Earth days: ${state.pastEarthDays} Lunar days: ${state.pastLunarDays}",
        Vector2(0, 0),
    );
    label.render(
        canvas,
        "(Current) Earth day ${state.earthDayProgress.toStringAsFixed(2)} Lunar day: ${state.lunarDayProgress.toStringAsFixed(2)}",
        Vector2(0, 20),
    );
    label.render(
        canvas,
        "Daytime ${state.daytime}",
        Vector2(0, 40),
    );
    label.render(
        canvas,
        "Speed factor ${state.speed}",
        Vector2(0, 60),
    );

    label.render(
        canvas,
        '''
        Food: ${state.resources.food}
        Energy: ${state.resources.energy}
        Alloys: ${state.resources.alloys}
        Concrete: ${state.resources.concrete}
        Water: ${state.resources.water.toStringAsFixed(2)}
        ''',
        Vector2(400, 10),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameRef.state.update(dt);
  }

  @override
  int priority = 10;
}
