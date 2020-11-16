import 'package:flame/extensions/vector2.dart';
import '../people_manager.dart';
import '../resources.dart';

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
  int id;

  List<Person> people = [];

  String _toString;

  @override
  String toString() => _toString ?? (_toString = type().toString());

  Station({
    this.position,
    this.id,
  });

  StationType type();
  int energyRequired();
  int energyProduction();
}

mixin FactoryStation on Station {

  double progress = 0.0;

  double workRequired();
  double individualWorkContribution();

  void applyProduction(Resources resource);

  void updateShift(Resources resources) {
    people.forEach((_) => progress += individualWorkContribution());

    if (progress >= workRequired()) {
      progress -= workRequired();

      applyProduction(resources);
    }
  }
}

class CommandCenter extends Station {
  StationType type() => StationType.COMMAND_CENTER;

  CommandCenter({ Vector2 position, int id }): super(position: position, id: id);

  int energyRequired() => 4;
  int energyProduction() => 0;
}

class Barracks extends Station {
  StationType type() => StationType.BARRACKS;

  Barracks({ Vector2 position, int id }): super(position: position, id: id);

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
    int id,
    this.capacity = 100,
  }): super(position: position, id: id);
}

class SolarPanel extends Station {
  StationType type() => StationType.SOLAR_PANEL;

  SolarPanel({ Vector2 position, int id }): super(position: position, id: id);

  int energyRequired() => 0;
  int energyProduction() => 10;
}

class Farm extends Station with FactoryStation {
  StationType type() => StationType.FARM;

  Farm({ Vector2 position, int id }): super(position: position, id: id);

  int energyRequired() => 1;
  int energyProduction() => 0;

  @override
  double workRequired() => 1.0;

  @override
  double individualWorkContribution() => 0.2;

  @override
  void applyProduction(Resources resources) {
    resources.food += 10;
  }
}
