import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/extensions/vector2.dart';
import 'package:flame/text_config.dart';

import 'dart:ui';

import '../game.dart';

class StationsComponent extends Component with HasGameRef<MoonGame> {
  static final stationSize = Vector2(200, 75);

  // Temp
  static final personPaint = Paint()..color = Color(0xFFB1B1B1);
  static final stationPaint = Paint()..color = Color(0xFFFFFFFF);
  static final stationOffPaint = Paint()..color = Color(0xFFA9A9A9);
  static final stationStrokePaint = Paint()..color = Color(0xFF00FF00)..style = PaintingStyle.stroke..strokeWidth = 2;
  static final roomNameConfig = TextConfig(
      fontSize: 10,
      color: Color(0xFF000000),
  );

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

      for (int i = 0; i < station.people.length; i++) {
        //final person = station.people[i];

        final personRect = Rect.fromLTWH(
            rect.left + (20 * i),
            rect.bottom - 20,
            10,
            20,
        );

        canvas.drawRect(personRect, personPaint);
      }

      roomNameConfig.render(canvas, station.toString(), Vector2(rect.left, rect.top));
    });

    canvas.restore();
  }

  @override
  int priority() => 3;
}
