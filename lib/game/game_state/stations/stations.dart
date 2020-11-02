import 'package:flame/extensions/vector2.dart';
import 'dart:math';

enum StationType {
  COMMAND_CENTER,
  BARRACKS,
  BATTERY_ROOM,
  SOLAR_PANEL,
  FARM,
  WORKSHOP,
  LANDING_PAD,
}

abstract class Station {
  final Vector2 position;
  bool powered = true;

  Station({
    this.position,
  });

  StationType type();
  int energyRequired();
  int energyProduction();
}

class CommandCenter extends Station {
  StationType type() => StationType.COMMAND_CENTER;

  CommandCenter({ Vector2 position }): super(position: position);

  int energyRequired() => 4;
  int energyProduction() => 0;
}

class Barracks extends Station {
  StationType type() => StationType.BARRACKS;

  Barracks({ Vector2 position }): super(position: position);

  int energyRequired() => 2;
  int energyProduction() => 0;
}

class BatteryRoom extends Station {
  StationType type() => StationType.BATTERY_ROOM;
  int energyRequired() => 0;
  int energyProduction() => 0;

  int capacity = 0;

  BatteryRoom({
    Vector2 position,
    this.capacity = 100,
  }): super(position: position);
}

class SolarPanel extends Station {
  StationType type() => StationType.SOLAR_PANEL;

  SolarPanel({ Vector2 position }): super(position: position);

  int energyRequired() => 0;
  int energyProduction() => 10;
}
