import 'package:flame/extensions/vector2.dart';
import 'package:flutter/animation.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/extensions/offset.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import '../game.dart';

class DaytimeBackground extends Component with HasGameRef<MoonGame> {
  static const EARTH_SIZE = 128.0;
  static const SUN_SIZE = 50.0;

  final sunPaint = Paint()..color = Color(0xFFFFFF00);

  Sprite earthSprite;
  Sprite sunSprite;

  ParametricCurve<Vector2> curve;
  bool daytime;
  Vector2 position;
  Vector2 size;

  @override
  void onMount() {
    calcTrajectory();

    earthSprite = Sprite(gameRef.images.fromCache('earth.png'));
    sunSprite = Sprite(gameRef.images.fromCache('sun.png'));
  }

  void calcTrajectory() {
    daytime = gameRef.state.daytime;

    if (!daytime) {
      curve = makeBodyParabola(-EARTH_SIZE, MoonGame.gameSize.x + EARTH_SIZE);
      position = curve.transform(0).toOffset().toVector2();
      size = Vector2.all(EARTH_SIZE);
    } else {
      curve = makeBodyParabola(MoonGame.gameSize.x + SUN_SIZE, -SUN_SIZE);
      position = curve.transform(0).toOffset().toVector2();
      size = Vector2.all(SUN_SIZE);
    }
  }

  _ParabolaCurve makeBodyParabola(double x0, double xf) {
    const y = 40.0;
    const parabolaHeight = 40.0;
    final xm = (x0 + xf) / 2;
    return _ParabolaCurve(
      p1: Vector2(x0, y),
      p2: Vector2(xf, y),
      p3: Vector2(xm, y - parabolaHeight),
      x0: x0,
      xf: xf,
    );
  }

  @override
  void render(Canvas canvas) {
    if (daytime) {
      sunSprite.render(canvas, position: position, size: size);
    } else {
      earthSprite.render(canvas, position: position, size: size);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.state.daytime != daytime) {
      calcTrajectory();
    } else {
      final progress = 1 - ((gameRef.state.lunarDayProgress - 0.5).abs() / 0.5);
      position = curve.transform(progress).toOffset().toVector2();
    }
  }

  @override
  int priority = 1;
}

class _ParabolaCurve extends ParametricCurve<Vector2> {
  double a, b, c;
  double x0, xf;

  _ParabolaCurve({
    @required Vector2 p1,
    @required Vector2 p2,
    @required Vector2 p3,
    @required this.x0,
    @required this.xf,
  }) {
    /**
		 * Adapted and modifed to get the unknowns for defining a parabola:
		 * http://stackoverflow.com/questions/717762/how-to-calculate-the-vertex-of-a-parabola-given-three-points
     *
     */

    double x1 = p1.x, y1 = p1.y, x2 = p2.x, y2 = p2.y, x3 = p3.x, y3 = p3.y;

    double denom = (x1 - x2) * (x1 - x3) * (x2 - x3);
    this.a = (x3 * (y2 - y1) + x2 * (y1 - y3) + x1 * (y3 - y2)) / denom;
    this.b = (x3 * x3 * (y1 - y2) + x2 * x2 * (y3 - y1) + x1 * x1 * (y2 - y3)) /
        denom;
    this.c = (x2 * x3 * (x2 - x3) * y1 +
            x3 * x1 * (x3 - x1) * y2 +
            x1 * x2 * (x1 - x2) * y3) /
        denom;
  }

  @override
  Vector2 transform(double t) {
    final x = x0 + (xf - x0) * t;
    final y = a * x * x + b * x + c;
    return Vector2(x, y);
  }
}
