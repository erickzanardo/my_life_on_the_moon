import 'package:flutter/material.dart';
import 'package:life_on_moon/game/game.dart';
import 'package:life_on_moon/widgets/container.dart';

import '../../widgets/title.dart';
import '../../widgets/button.dart';

class StationDetailsPanelOverlay extends StatelessWidget {
  static const OVERLAY_ID = 'StationDetailsPanelOverlay';

  final MoonGame game;

  StationDetailsPanelOverlay(this.game);

  @override
  Widget build(_) {
    return Center(
      child: GameContainer(
        width: 550,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameTitle(game.selectedStation?.humanName()),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child:GameButton(
                    label: 'Close',
                    onPress: () {
                      game.overlays.remove(OVERLAY_ID);
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
