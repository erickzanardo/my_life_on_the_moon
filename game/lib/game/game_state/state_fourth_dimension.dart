 const EARTH_DAY_DURATION = 60; // secs (2 minutes)
 const WORKDAY_DAY_DURATION = EARTH_DAY_DURATION * 0.4;
 const LUNAR_DAY_DURATION = EARTH_DAY_DURATION * 27;

mixin StateFourthDimension {

  int pastEarthDays = 0;
  int pastLunarDays = 0;

  double currentLunarDay = 0.0;
  double currentEarthDay = 0.0;

  bool _isWorkDay = true;
  int _speed = 100;

  List<void Function()> earthDayTicker = [];
  List<void Function()> workDayTicker = [];
  List<void Function()> lunarDayTicker = [];

  void pauseSpeed() {
    _speed = 0;
  }

  void normalSpeed() {
    _speed = 1;
  }

  void fastSpeed() {
    _speed = 3;
  }

  void superFastSpeed() {
    _speed = 9;
  }

  void ultraFastSpeed() {
    _speed = 20;
  }

  void updateTime(double dt)  {
    double _dt = dt * _speed;

    currentEarthDay += _dt;
    currentLunarDay += _dt;

    if (currentEarthDay >= WORKDAY_DAY_DURATION && _isWorkDay) {
      workDayTicker.forEach((ticker) => ticker.call());
      _isWorkDay = false;
    }

    if (currentEarthDay >= EARTH_DAY_DURATION) {
      earthDayTicker.forEach((ticker) => ticker.call());
      _isWorkDay = true;

      pastEarthDays++;
      currentEarthDay -= EARTH_DAY_DURATION;
    }

    if (currentLunarDay >= LUNAR_DAY_DURATION) {
      lunarDayTicker.forEach((ticker) => ticker.call());

      pastLunarDays++;
      currentLunarDay -= LUNAR_DAY_DURATION;
    }
  }

  get earthDayProgress => currentEarthDay / EARTH_DAY_DURATION;
  get lunarDayProgress => currentLunarDay / LUNAR_DAY_DURATION;
  bool get daytime => lunarDayProgress <= 0.5;
  int get speed => _speed;
}
