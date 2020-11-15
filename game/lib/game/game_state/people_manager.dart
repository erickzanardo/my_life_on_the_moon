import './game_state.dart';
import 'stations/stations.dart';

class Person {
  String name;
  int age;
  int health;
  int hunger;

  int workingStationId;
}

mixin PeopleManager {
  List<Person> people = [];

  void onWorkDayEnd(GameState state) {
    _resetStations(state);
    List<Person> toRemove = [];
    people.forEach((person) {

      if (state.resources.food > 0) {
        state.resources.food--;
      } else {
        person.hunger--;
      }

      if (person.hunger <= 0) {
        person.health--;
      }

      if (person.health <= 0) {
        toRemove.add(person);
        // better notification
        print('${person.name} died of starvation');
      } else {
        findBarracks(state)?.people?.add(person);
      }
    });

    toRemove.forEach((p) => people.remove(p));
  }

  Station findBarracks(GameState state) {
    return state.stations.firstWhere((s) => s.type() == StationType.BARRACKS);
  }

  void _resetStations(GameState state) {
    state.stations.forEach((s) => s.people.clear());
  }

  void onDayBegin(GameState state) {
    _resetStations(state);
    people.forEach((person) {
      final workingStation = state.stations.firstWhere((s) => s.id == person.workingStationId);
      workingStation?.people?.add(person);
    });
  }
}
