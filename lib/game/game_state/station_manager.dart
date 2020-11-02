import 'package:flame/extensions/vector2.dart';

import 'resources.dart';

import 'stations/stations.dart';

mixin StationManager {
  List<Station> stations = [
    CommandCenter(position: Vector2(1, 0)),
    SolarPanel(position: Vector2(0, 0)),
    BatteryRoom(position: Vector2(-1, 0)),
  ];

  int _energyProduction() {
    return stations
        .whereType<SolarPanel>()
        .fold(0, (value, panel) => value + panel.energyProduction());
  }

  BatteryRoom _batteryRoom() => stations.whereType<BatteryRoom>().toList()[0];

  void stationCycle(Resources resources, bool daytime) {
    final battery = _batteryRoom();

    if (daytime) {
      int energyProduced = _energyProduction();

      stations.forEach((station) {
        if (energyProduced >= station.energyRequired()) {
          energyProduced -= station.energyRequired();
          station.powered = true;
        } else {
          station.powered = false;
        }
      });

      resources.storeEnergy(energyProduced, battery.capacity);
    } else {
      final battery = _batteryRoom();
      stations.forEach((station) {
        if (resources.energy >= station.energyRequired()) {
          resources.storeEnergy(-station.energyRequired(), battery.capacity);
          station.powered = true;
        } else {
          station.powered = false;
        }
      });
    }
  }
}
