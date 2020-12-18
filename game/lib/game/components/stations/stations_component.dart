import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';

import '../../game.dart';
import './renderers/renderers.dart';

class StationsComponent extends Component with HasGameRef<MoonGame> {

  Map<int, StationRenderer> renderers = {};
  Vector2 offset;

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
  void onMount() {
    calcOffset();
  }

  void calcOffset() {
    offset = Vector2(gameRef.size.x / 2, gameRef.size.y - 20); // Small border
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    calcOffset();
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(gameRef.panOffest.x, gameRef.panOffest.y);
    canvas.translate(offset.x, offset.y);
    canvas.scale(gameRef.zoomFactor, gameRef.zoomFactor);

    renderers.values.forEach((r) => r.render(canvas));

    canvas.restore();
  }

  @override
  int priority = 3;

  void onTap(Vector2 screenPos) {
    final panPos = screenPos - gameRef.panOffest;
    final translated = (panPos - offset) / gameRef.zoomFactor;

    final station = gameRef.state.stations.firstWhere(
        (s) => createStationRect(s).contains(translated.toOffset()),
        orElse: () => null,
    );

    if (station != null) {
      gameRef.onSelectStation(station);
    }
  }
}
