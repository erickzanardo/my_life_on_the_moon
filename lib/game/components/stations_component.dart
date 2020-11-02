import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/extensions/vector2.dart';

import 'dart:ui';

import '../game.dart';

class StationsComponent extends Component with HasGameRef<MoonGame> {
  static final stationSize = Vector2(200, 75);

  // Temp
  static final stationPaint = Paint()..color = Color(0xFFFFFFFF);
  static final stationOffPaint = Paint()..color = Color(0xFFA9A9A9);
  static final stationStrokePaint = Paint()..color = Color(0xFF00FF00)..style = PaintingStyle.stroke..strokeWidth = 2;

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(MoonGame.gameSize.x / 2, MoonGame.gameSize.y - 20); // Small border

    gameRef.state.stations.forEach((station) {
      final rect = Rect.fromCenter(
          center: Offset(
              station.position.x * stationSize.x,
              station.position.y * stationSize.y,
          ),
          width: stationSize.x,
          height: stationSize.y,
      );

      canvas.drawRect(
          rect,
          station.powered ? stationPaint : stationOffPaint,
      );
      canvas.drawRect(
          rect,
          stationStrokePaint,
      );
    });

    canvas.restore();
  }

  @override
  int priority() => 3;
}
