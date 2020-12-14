import 'package:flutter/material.dart';
import 'package:life_on_moon/game/game.dart';
import 'package:life_on_moon/widgets/container.dart';

import '../../widgets/title.dart';
import '../../widgets/button.dart';
import '../game_state/stations/stations.dart';

class StationDetailsPanelOverlay extends StatelessWidget {
  static const OVERLAY_ID = 'StationDetailsPanelOverlay';

  final MoonGame game;
  final Station station;

  StationDetailsPanelOverlay(this.game, this.station);

  @override
  Widget build(_) {
    return Center(
      child: GameContainer(
        width: 550,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameTitle(station.humanName()),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child:GameButton(
                    label: 'Close',
                    onPress: () {
                      game.removeWidgetOverlay(OVERLAY_ID);
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
