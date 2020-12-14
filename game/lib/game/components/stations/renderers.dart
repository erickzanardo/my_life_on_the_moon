import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame/text_config.dart';

import 'dart:ui';

import '../../game_state/stations/stations.dart';
import '../../game.dart';

StationRenderer stationRenderFactory(Station station, MoonGame game) {
  switch(station.type()) {
    case StationType.COMMAND_CENTER:
      return BasicAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/command_center.png'),
          amount: 8,
          stepTime: 0.15
      );
    case StationType.BATTERY_ROOM:
      return BasicAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/battery_room.png'),
          amount: 12,
          stepTime: 0.1
      );
    case StationType.FARM:
      return BasicAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/farm.png'),
          amount: 4,
          stepTime: 0.2
      );
    default:
      return GenericStationRenderer(station, game);
  }
}

abstract class StationRenderer {
  static final personPaint = Paint()..color = Color(0xFFB1B1B1);
  static final stationSize = Vector2(150, 50);
  static final stationOffPaint = Paint()..color = Color(0xAA000000);

  final Station station;
  final MoonGame gameRef;

  StationRenderer(this.station, this.gameRef);

  void update(double dt) {}

  void render(Canvas canvas) {
    final rect = Rect.fromCenter(
        center: Offset(
            station.position.x * stationSize.x,
            station.position.y * stationSize.y,
        ),
        width: stationSize.x,
        height: stationSize.y,
    );
    _processBackgroundRendering(canvas, rect);

    if (station is HumanOperatedStation) {
      for (int i = 0; i < (station as HumanOperatedStation).people.length; i++) {
        //final person = station.people[i];

        final personRect = Rect.fromLTWH(
            rect.left + (20 * i),
            rect.bottom - 20,
            10,
            20,
        );

        canvas.drawRect(personRect, personPaint);
      }
    }

    if (!station.powered) {
      canvas.drawRect(rect, stationOffPaint);
    }
  }

  void _processBackgroundRendering(Canvas canvas, Rect rect);
}

class GenericStationRenderer extends StationRenderer {
  static final stationPaint = Paint()..color = Color(0xFFFFFFFF);
  static final stationStrokePaint = Paint()..color = Color(0xFF00FF00)..style = PaintingStyle.stroke..strokeWidth = 2;
  static final roomNameConfig = TextConfig(
      fontSize: 10,
      color: Color(0xFF000000),
  );

  GenericStationRenderer(Station station, MoonGame gameRef): super(station, gameRef);

  @override
  void _processBackgroundRendering(Canvas canvas, Rect rect) {
    canvas.drawRect(
        rect,
        stationPaint,
    );
    canvas.drawRect(
        rect,
        stationStrokePaint,
    );
    roomNameConfig.render(canvas, station.toString(), Vector2(rect.left, rect.top));
  }
}

class BasicAnimationRenderer extends StationRenderer {
  SpriteAnimation _animation;

  BasicAnimationRenderer(
      Station station,
      MoonGame gameRef,
      Image image, {
      int amount,
      double stepTime,
  }): super(station, gameRef) {
    _animation = SpriteAnimation.sequenced(
        image,
        amount,
        textureSize: Vector2(150, 50),
        stepTime: stepTime,
    );
  }

  @override
  void update(double dt) => _animation.update(dt * gameRef.state.speed);

  @override
  void _processBackgroundRendering(Canvas canvas, Rect rect) {
    _animation.getSprite().renderRect(canvas, rect);
  }
}
