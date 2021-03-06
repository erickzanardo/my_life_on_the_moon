import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite_animation.dart';
import 'package:flame/text_config.dart';

import 'dart:ui';

import '../../../game_state/stations/stations.dart';
import '../../../game.dart';

import './barracks.dart';

StationRenderer stationRenderFactory(Station station, MoonGame game) {
  switch(station.type()) {
    case StationType.COMMAND_CENTER:
      return WorkShiftOnlyAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/command_center.png'),
          amount: 8,
          stepTime: 0.15,
      );
    case StationType.BATTERY_ROOM:
      return BasicAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/battery_room.png'),
          amount: 12,
          stepTime: 0.1,
      );
    case StationType.FARM:
      return WorkShiftOnlyAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/farm.png'),
          amount: 4,
          stepTime: 0.2,
      );
    case StationType.SOLAR_PANEL:
      return DayOnlyAnimationRenderer(
          station,
          game,
          game.images.fromCache('stations/solar_panel.png'),
          amount: 4,
          stepTime: 0.25,
      );
    case StationType.BARRACKS:
      return BarracksRenderer(
          station,
          game,
      );
    default:
      return GenericStationRenderer(station, game);
  }
}

final stationSize = Vector2(150, 50);
Rect createStationRect(Station station) => Rect.fromCenter(
    center: Offset(
        station.position.x * stationSize.x,
        station.position.y * stationSize.y,
    ),
    width: stationSize.x,
    height: stationSize.y,
);

abstract class StationRenderer {
  static final personPaint = Paint()..color = Color(0xFFB1B1B1);
  static final stationOffPaint = Paint()..color = Color(0xAA000000);

  final Station station;
  final MoonGame gameRef;

  Rect rect;
  Vector2 position;
  Vector2 size;
  Vector2 personSize = Vector2(8, 16);

  StationRenderer(this.station, this.gameRef) {
    rect = createStationRect(station);
    position = Vector2(rect.left, rect.top);
    size = Vector2(rect.width, rect.height);
  }

  void update(double dt) {}

  void render(Canvas canvas) {
    processBackgroundRendering(canvas);
    renderPeople(canvas);

    if (!station.powered) {
      canvas.drawRect(rect, stationOffPaint);
    }
  }

  void processBackgroundRendering(Canvas canvas);

  void renderPeople(Canvas canvas) {
    if (station is HumanOperatedStation) {
      for (int i = 0; i < (station as HumanOperatedStation).people.length; i++) {
        //final person = station.people[i];

        final personRect = Rect.fromLTWH(
            rect.left + (20 * i),
            rect.bottom - 20,
            personSize.x,
            personSize.y,
        );

        canvas.drawRect(personRect, personPaint);
      }
    }

  }
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
  void processBackgroundRendering(Canvas canvas) {
    canvas.drawRect(
        rect,
        stationPaint,
    );
    canvas.drawRect(
        rect,
        stationStrokePaint,
    );
    roomNameConfig.render(canvas, station.toString(), position);
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
    _animation = SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
            amount: amount,
            textureSize: Vector2(150, 50),
            stepTime: stepTime,
        ),
    );
  }

  @override
  void update(double dt) => _animation.update(dt * gameRef.state.speed);

  @override
  void processBackgroundRendering(Canvas canvas) {
    _animation.getSprite().render(canvas, position: position, size: size);
  }
}

class DayOnlyAnimationRenderer extends BasicAnimationRenderer {
  DayOnlyAnimationRenderer(
      Station station,
      MoonGame gameRef,
      Image image, {
      int amount,
      double stepTime,
  }) : super(station, gameRef, image, amount: amount, stepTime: stepTime);

  @override
  void update(double dt) {
    if (gameRef.state.daytime) {
      super.update(dt);
    }
  }
}

class WorkShiftOnlyAnimationRenderer extends BasicAnimationRenderer {
  WorkShiftOnlyAnimationRenderer(
      Station station,
      MoonGame gameRef,
      Image image, {
      int amount,
      double stepTime,
  }) : super(station, gameRef, image, amount: amount, stepTime: stepTime);

  @override
  void update(double dt) {
    if (gameRef.state.isWorkDay) {
      super.update(dt);
    }
  }
}

