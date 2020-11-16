import 'dart:math';

class Resources {
  int food = 0;
  int energy = 0;
  int alloys = 0;
  int concrete = 0;

  double water = 0.0;

  double _usedWater = 0.0;

  void storeEnergy(int ammount, int capacity)  {
    energy = min(capacity, energy + ammount);
  }

  void consumeWater(double ammount) {
    water -= ammount;
    _usedWater += ammount;
  }

  void recycleWater() {
    water += _usedWater * 0.9;
    _usedWater = 0;
  }
}
