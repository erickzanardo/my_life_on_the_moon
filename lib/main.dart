import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import 'dart:io' show Platform;

import 'screens/game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await Flame.util.fullScreen();
  }

  runApp(GameWidget());
}

class GameWidget extends StatelessWidget {
  @override
  Widget build(_) {
    return MaterialApp(
        routes: {
          '/game': (_) => MoonGameScreen(),
        },
        initialRoute: '/game',
    );
  }
}
