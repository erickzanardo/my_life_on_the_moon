import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';

import '../../game.dart';
import './renderers.dart';

class StationsComponent extends Component with HasGameRef<MoonGame> {

  Map<int, StationRenderer> renderers = {};
  Vector2 offset = Vector2(MoonGame.gameSize.x / 2, MoonGame.gameSize.y - 20); // Small border

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
    canvas.translate(offset.x, offset.y);

    canvas.scale(gameRef.zoomFactor, gameRef.zoomFactor);
    canvas.translate(gameRef.panOffest.x, gameRef.panOffest.y);

    renderers.values.forEach((r) => r.render(canvas));

    canvas.restore();
  }

  @override
  int priority = 3;

  void onTap(Vector2 screenPos) {
    final panPos = (screenPos - gameRef.panOffest) * gameRef.zoomFactor;
    final translated = (panPos - offset);

    final station = gameRef.state.stations.firstWhere(
        (s) => createStationRect(s).contains(translated.toOffset()),
        orElse: () => null,
    );

    if (station != null) {
      gameRef.onSelectStation(station);
    }
  }
}
