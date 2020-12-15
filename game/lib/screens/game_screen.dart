import 'package:flutter/material.dart';
import 'package:flame/game/game_widget.dart';
import 'package:life_on_moon/game/widgets/station_details_panel.dart';
import 'package:life_on_moon/game/widgets/station_list_panel.dart';

import '../game/game.dart';

import '../game/widgets/speed_control_overlay.dart';
import '../game/widgets/side_menu_overlay.dart';

class MoonGameScreen extends StatelessWidget {
  @override
  Widget build(_) {
    final game = MoonGame();
    return Scaffold(
        body: GameWidget(
            game: game,
            overlayBuilderMap: {
              SpeedControlOverlay.OVERLAY_ID: (_) => SpeedControlOverlay(game),
              SideMenuOverlay.OVERLAY_ID: (_) => SideMenuOverlay(game),
              StationDetailsPanelOverlay.OVERLAY_ID: (_) => StationDetailsPanelOverlay(game),
              StationListPanel.OVERLAY_ID: (_) => StationListPanel(game),
            },
        ),
    );
  }
}
