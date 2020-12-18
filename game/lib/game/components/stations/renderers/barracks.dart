import 'package:flame/extensions/vector2.dart';
import 'package:flame/sprite.dart';
import 'dart:ui';

import '../../../game_state/stations/stations.dart';
import '../../../game.dart';
import './renderers.dart';

class BarracksRenderer extends StationRenderer {

  final _bedPositions = [
    Vector2(40, 7),
    Vector2(40, 26),

    Vector2(80, 7),
    Vector2(80, 26),

    Vector2(120, 7),
    Vector2(120, 26),
  ];

  Sprite _sprite;

  BarracksRenderer(Station station, MoonGame game): super(station, game) {
    _sprite = Sprite(gameRef.images.fromCache('stations/barracks.png'));
  }

  @override
  void processBackgroundRendering(Canvas canvas) {
    _sprite.render(canvas, position: position, size: size);
  }

  @override 
  void renderPeople(Canvas canvas) {
    if (station is HumanOperatedStation) {
      for (int i = 0; i < (station as HumanOperatedStation).people.length; i++) {
        //final person = station.people[i];

        final personRect = Rect.fromLTWH(
            position.x + _bedPositions[i].x,
            position.y + _bedPositions[i].y,
            personSize.y,
            personSize.x,
        );

        canvas.drawRect(personRect, StationRenderer.personPaint);
      }
    }

  }
}
