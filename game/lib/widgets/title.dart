
import 'package:flutter/cupertino.dart';
import 'package:life_on_moon/palette.dart';

class GameTitle extends StatelessWidget {

  final String title;

  GameTitle(this.title);

  @override
  Widget build(_) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Palette.WHITE,
                    width: 2,
                ),
            ),
        ),
        child: Text(
            title,
            style: TextStyle(
                color: Palette.WHITE,
                fontSize: 28,
            ),
        ),
    );
  }
}
