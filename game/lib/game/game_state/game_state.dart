
import 'state_fourth_dimension.dart';
import 'resources.dart';
import 'station_manager.dart';
import 'people_manager.dart';

class GameState with StateFourthDimension, StationManager, PeopleManager {
  Resources resources = Resources();

  GameState() {
    earthDayTicker.add(() {
      onDayBegin(this);
      stationCycle(resources, daytime);
    });

    workDayTicker.add(() {
      stationWorkCycle(resources);
      onWorkDayEnd(this);
    });
  }

  void update(double dt) {
    updateTime(dt);
  }
}
