import 'package:flutter/material.dart';
import 'package:life_on_moon/widgets/container.dart';

import '../../widgets/icon.dart';
import '../game_state/state_fourth_dimension.dart';
import '../game.dart';

class SpeedControlOverlay extends StatefulWidget {

  final MoonGame game;

  SpeedControlOverlay(this.game);

  @override
  State<StatefulWidget> createState() {
    return _SpeedControlOverlay();
  }
}

class _SpeedControlOverlay extends State<SpeedControlOverlay> {

  int _currentValue;

  @override
  void initState() {
    super.initState();

    _currentValue = widget.game.state.speed;
  }

  @override
  Widget build(BuildContext context) {

    void _updateValue(int value) {
      setState(() {
        _currentValue = value;
        widget.game.state.speed = value;
      });
    }

    return Positioned(
        top: 10,
        right: 50,
        child: GameContainer(
            width: 75,
            child: Column(
                children: [
                  _SpeedIcon(
                      icon: Icons.pause,
                      speedValue: PAUSE_SPEED,
                      currentValue: _currentValue,
                      onUpdate: _updateValue,
                  ),
                  _SpeedIcon(
                      icon: Icons.play_arrow,
                      speedValue: NORMAL_SPEED,
                      currentValue: _currentValue,
                      onUpdate: _updateValue,
                  ),
                  _SpeedIcon(
                      icon: Icons.fast_forward,
                      speedValue: FAST_SPEED,
                      currentValue: _currentValue,
                      onUpdate: _updateValue,
                  ),
                  _SpeedIcon(
                      icon: Icons.flash_on,
                      speedValue: ULTRA_FAST_SPEED,
                      currentValue: _currentValue,
                      onUpdate: _updateValue,
                  ),
                ],
            ),
        ),
    );
  }
}

class _SpeedIcon extends StatelessWidget {

  final IconData icon;
  final int speedValue;
  final int currentValue;
  final Function(int) onUpdate;

  _SpeedIcon({
    this.icon,
    this.speedValue,
    this.currentValue,
    this.onUpdate,
  });

  @override
  Widget build(_) {
    return GameIcon(
        onClick: () => onUpdate(speedValue),
        icon: icon,
        selected: currentValue == speedValue,
    );
  }
}
