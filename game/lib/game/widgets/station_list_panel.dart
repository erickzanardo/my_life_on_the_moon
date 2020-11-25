import 'package:flutter/material.dart';
import 'package:life_on_moon/game/game_state/stations/stations.dart';
import 'package:life_on_moon/palette.dart';
import 'package:life_on_moon/widgets/container.dart';

import '../../widgets/icon.dart';
import '../../widgets/label.dart';
import '../../widgets/title.dart';
import '../../widgets/button.dart';
import '../../widgets/clickable.dart';
import '../game.dart';

class StationListPanel extends StatelessWidget {
  static const OVERLAY_ID = 'StationListPanelOverlay';

  final MoonGame game;

  StationListPanel(this.game);

  @override
  Widget build(_) {
    return Center(
      child: GameContainer(
        width: 550,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GameTitle('Stations'),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: game.state.stations.map((station) {
                  final hasWorkers = station is HumanOperatedStation;
                  final maxWorkers = hasWorkers
                      ? (station as HumanOperatedStation).maxWorkers()
                      : null;
                  final currentWorkers = hasWorkers
                      ? game.state.listPeopleWorkingOn(station.id).length
                      : null;

                  return _StationItem(
                    stationName: station.humanName(),
                    maxWorkers: maxWorkers,
                    currentWorkers: currentWorkers,
                  );
                }).toList(),
              ),
            )),
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

class _StationItem extends StatelessWidget {
  final VoidCallback onClick;
  final String stationName;
  final int currentWorkers;
  final int maxWorkers;

  _StationItem({
    this.onClick,
    this.stationName,
    this.currentWorkers,
    this.maxWorkers,
  });

  @override
  Widget build(BuildContext context) {
    return GameClickable(
      child: Container(
        height: 40,
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GameLabel(stationName),
            if (maxWorkers != null)
              Row(children: [
                GameIcon(icon: Icons.supervised_user_circle),
                SizedBox(
                    width: 40,
                    child: GameLabel('${currentWorkers ?? '-'}/$maxWorkers'),
                ),
              ]),
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: Palette.WHITE,
          )),
        ),
      ),
      onClick: onClick,
    );
  }
}
