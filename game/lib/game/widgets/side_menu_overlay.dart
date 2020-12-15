import 'package:flutter/material.dart';
import 'package:life_on_moon/widgets/container.dart';

import './station_list_panel.dart';

import '../../widgets/icon.dart';
import '../game.dart';

class SideMenuOverlay extends StatefulWidget {

  static const OVERLAY_ID = 'SideMenuOverlay';

  final MoonGame game;

  SideMenuOverlay(this.game);

  @override
  State<StatefulWidget> createState() {
    return _SideMenuOverlay();
  }
}

class _SideMenuOverlay extends State<SideMenuOverlay> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Positioned(
        top: 10,
        right: 50,
        child: GameContainer(
            width: 75,
            child: Column(
                children: [
                  GameIcon(
                      icon: Icons.apartment,
                      selected: false,
                      onClick: () {
                        widget.game.overlays.add(StationListPanel.OVERLAY_ID);
                      },
                  ),
                ],
            ),
        ),
    );
  }
}
