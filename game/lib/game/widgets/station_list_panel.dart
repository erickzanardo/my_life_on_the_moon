import 'package:flutter/material.dart';
import 'package:life_on_moon/widgets/container.dart';

import '../../widgets/label.dart';
import '../../widgets/title.dart';
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
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GameTitle('Stations'),
                      ...game.state.stations.map((station) {
                        return GameLabel(station.humanName());
                      }).toList()
                    ],
                ),
            ),
        ),
    );
  }
}
