import 'package:flame/extensions/vector2.dart';

import 'resources.dart';

import 'stations/stations.dart';

mixin StationManager {
  List<Station> stations = [
    CommandCenter(position: Vector2(1, 0), id: 1),
    SolarPanel(position: Vector2(0, 0), id: 2),
    BatteryRoom(position: Vector2(-1, 0), id: 3),
    Farm(position: Vector2(0, -1), id: 4),
  ];

  int _energyProduction() {
    return stations
        .whereType<SolarPanel>()
        .fold(0, (value, panel) => value + panel.energyProduction());
  }

  int batteryRoomCapacity() => stations
      .whereType<BatteryRoom>()
      .fold(0, (value, room) => value + room.capacity);


  void stationCycle(Resources resources, bool daytime) {
    final capacity = batteryRoomCapacity();

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

      resources.storeEnergy(energyProduced, capacity);
    } else {
      stations.forEach((station) {
        if (resources.energy >= station.energyRequired()) {
          resources.storeEnergy(-station.energyRequired(), capacity);
          station.powered = true;
        } else {
          station.powered = false;
        }
      });
    }
  }
}
