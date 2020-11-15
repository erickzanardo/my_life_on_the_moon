class Person {
  String name;
  int age;
  int health;
  int hunger;

  int workingStationId;
  int currentStationId;
}

mixin PeopleManager {
  List<Person> people = [];
}
