import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';

import '../../game.dart';
import './renderers.dart';

class StationsComponent extends Component with HasGameRef<MoonGame> {

  Map<int, StationRenderer> renderers = {};

  @override
  void update(double dt) {
    super.update(dt);

    gameRef.state.stations.forEach((station) {
      renderers
          .putIfAbsent(station.id, () => stationRenderFactory(station, gameRef))
          .update(dt);
    });

  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(MoonGame.gameSize.x / 2, MoonGame.gameSize.y - 20); // Small border

    renderers.values.forEach((r) => r.render(canvas));

    canvas.restore();
  }

  @override
  int priority = 3;
}
