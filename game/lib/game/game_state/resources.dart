import 'dart:math';

class Resources {
  int food = 0;
  int energy = 0;
  int alloys = 0;
  int concrete = 0;
  int water = 0;

  void storeEnergy(int ammount, int capacity)  {
    energy = min(capacity, energy + ammount);
  }
}
