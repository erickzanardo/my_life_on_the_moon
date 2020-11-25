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
  WATER_MINE,
  CONCRETE_FACTORY,
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
  bool hasEnoughResources = false;

  double workRequired();
  double individualWorkContribution();

  void applyProduction(Resources resource);

  void updateShift(Resources resources) {
    if (hasEnoughResources) {
      people.forEach((_) => progress += individualWorkContribution());

      if (progress >= workRequired()) {
        progress -= workRequired();

        applyProduction(resources);
      }
    }
  }

  void consumeResources(Resources resources);
}

class CommandCenter extends Station {
  StationType type() => StationType.COMMAND_CENTER;

  CommandCenter({Vector2 position, int id}) : super(position: position, id: id);

  int energyRequired() => 4;
  int energyProduction() => 0;
}

class Barracks extends Station {
  StationType type() => StationType.BARRACKS;

  Barracks({Vector2 position, int id}) : super(position: position, id: id);

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
    this.capacity = 150,
  }) : super(position: position, id: id);
}

class SolarPanel extends Station {
  StationType type() => StationType.SOLAR_PANEL;

  SolarPanel({Vector2 position, int id}) : super(position: position, id: id);

  int energyRequired() => 0;
  int energyProduction() => 12;
}

class Farm extends Station with FactoryStation {
  StationType type() => StationType.FARM;

  Farm({Vector2 position, int id}) : super(position: position, id: id);

  int energyRequired() => 1;
  int energyProduction() => 0;

  @override
  double workRequired() => 1.0;

  @override
  double individualWorkContribution() => 0.2;

  @override
  void applyProduction(Resources resources) {
    resources.food += 12;
  }

  @override
  void consumeResources(Resources resources) {
    if (resources.water >= 1) {
      resources.consumeWater(1);
      hasEnoughResources = true;
    } else {
      hasEnoughResources = false;
    }
  }
}

class WaterMine extends Station with FactoryStation {
  StationType type() => StationType.WATER_MINE;

  WaterMine({Vector2 position, int id}) : super(position: position, id: id);

  int energyRequired() => 2;
  int energyProduction() => 0;

  @override
  double workRequired() => 1.2;

  @override
  double individualWorkContribution() => 0.6;

  @override
  void applyProduction(Resources resources) {
    resources.water += 6;
  }

  @override
  void consumeResources(_) {
    hasEnoughResources = true;
  }
}

class ConcreteFactory extends Station with FactoryStation {
  StationType type() => StationType.CONCRETE_FACTORY;

  ConcreteFactory({Vector2 position, int id})
      : super(position: position, id: id);

  int energyRequired() => 2;
  int energyProduction() => 0;

  @override
  double workRequired() => 1.2;

  @override
  double individualWorkContribution() => 0.6;

  @override
  void applyProduction(Resources resources) {
    resources.concrete += 2;
  }

  @override
  void consumeResources(_) {
    hasEnoughResources = true;
  }
}
