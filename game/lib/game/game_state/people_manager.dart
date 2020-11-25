import './game_state.dart';
import 'stations/stations.dart';

class Person {
  String name;
  int age;
  int health = 3;
  int hunger = 8;
  int thirsty = 3;

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
        print('${person.name} is starving');
      }

      if (state.resources.water > 0) {
        state.resources.consumeWater(1);
      } else {
        person.thirsty--;
      }

      if (person.thirsty <= 0) {
        person.health--;
        print('${person.name} is thirsty');
      }

      if (person.health <= 0) {
        toRemove.add(person);
        // better notification
        print('${person.name} died');
      } else {
        findBarracks(state)?.people?.add(person);
      }
    });

    toRemove.forEach((p) => people.remove(p));
  }

  List<Person> listPeopleWorkingOn(int id) =>
      people.where((p) => p.workingStationId == id).toList();

  Barracks findBarracks(GameState state) {
    return state.stations.firstWhere((s) => s.type() == StationType.BARRACKS);
  }

  List<HumanOperatedStation> _humanOperatedStations(GameState state) => state.stations.whereType<HumanOperatedStation>().toList();

  void _resetStations(GameState state) {
    _humanOperatedStations(state).forEach((s) => s.people.clear());
  }

  void onDayBegin(GameState state) {
    _resetStations(state);
    people.forEach((person) {
      final workingStation = state.stations.firstWhere((s) => s.id == person.workingStationId);
      if (workingStation is HumanOperatedStation) {
        workingStation?.people?.add(person);
      } else {
        print('Invalid station as working place');
      }
    });
  }
}
