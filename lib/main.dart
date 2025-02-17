import 'package:flutter/material.dart';
import 'package:card_game/screens/game_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
    ),
    home: const GameScreen(),
  ));
}
