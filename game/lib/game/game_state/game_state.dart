
import 'state_fourth_dimension.dart';
import 'resources.dart';
import 'station_manager.dart';

class GameState with StateFourthDimension, StationManager {
  Resources resources = Resources();

  GameState() {
    earthDayTicker.add(() {
      stationCycle(resources, daytime);
    });
  }

  void update(double dt) {
    updateTime(dt);
  }
}
