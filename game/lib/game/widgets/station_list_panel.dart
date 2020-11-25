import 'package:flutter/material.dart';
import 'package:life_on_moon/widgets/container.dart';

import '../../widgets/label.dart';
import '../../widgets/title.dart';
import '../../widgets/button.dart';
import '../game.dart';

class StationListPanel extends StatelessWidget {
  static const OVERLAY_ID = 'StationListPanelOverlay';

  final MoonGame game;

  StationListPanel(this.game);

  @override
  Widget build(_) {
    return Center(
        child: GameContainer(
            width: 450,
            height: 300,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GameTitle('Stations'),
                  Expanded(child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: game.state.stations.map((station) {
                            return GameLabel(station.humanName());
                          }).toList(),
                      ),
                  )),
                  GameButton(
                      label: 'Close',
                      onPress: () {
                        game.removeWidgetOverlay(OVERLAY_ID);
                      }
                  ),
                ],
            ),
        ),
    );
  }
}
