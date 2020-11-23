import 'package:flutter/animation.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import 'dart:ui';

import '../game.dart';

class DaytimeBackground extends Component with HasGameRef<MoonGame> {

  static const EARTH_SIZE = 128;
  static const SUN_SIZE = 50;

  final sunPaint = Paint()..color = Color(0xFFFFFF00);

  Sprite earthSprite;
  Sprite sunSprite;

  Tween<double> tween;
  bool daytime;
  Rect rect;

  @override
  void onMount() {
    calcTrajectory();

    earthSprite = Sprite(gameRef.images.fromCache('earth.png'));
    sunSprite = Sprite(gameRef.images.fromCache('sun.png'));
  }

  void calcTrajectory() {
    daytime = gameRef.state.daytime;

    if (!daytime) {
      tween = Tween(
          begin: -EARTH_SIZE.toDouble(),
          end: MoonGame.gameSize.x + EARTH_SIZE,
      );
      rect = Rect.fromLTWH(MoonGame.gameSize.x, 40, EARTH_SIZE.toDouble(), EARTH_SIZE.toDouble());
    } else {
      tween = Tween(
          begin: MoonGame.gameSize.x + SUN_SIZE,
          end: -SUN_SIZE.toDouble(),
      );
      rect = Rect.fromLTWH(MoonGame.gameSize.x, 40, SUN_SIZE.toDouble(), SUN_SIZE.toDouble());
    }
  }

  @override
  void render(Canvas canvas) {
    if (daytime) {
      sunSprite.renderRect(canvas, rect);
    } else {
      earthSprite.renderRect(canvas, rect);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.state.daytime != daytime) {
      calcTrajectory();
    } else {
      final progress = 1 - ((gameRef.state.lunarDayProgress - 0.5).abs() / 0.5);
      rect = Rect.fromLTWH(
          tween.transform(progress),
          rect.top,
          rect.width,
          rect.height,
      );
    }
  }

  @override
  int priority = 1;
}
