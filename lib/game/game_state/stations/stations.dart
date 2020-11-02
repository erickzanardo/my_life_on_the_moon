import 'package:flame/extensions/vector2.dart';

enum StationType {
  COMMAND_CENTER,
  BARRACKS,
  FARM,
  WORKSHOP,
  SOLAR_PANEL,
}

class Station {
  final Vector2 position;

  Station({
    this.position,
  });
}
