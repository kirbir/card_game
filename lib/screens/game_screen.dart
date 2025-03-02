import 'package:flutter/material.dart';
import 'package:card_game/components/game_board.dart';


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Game'),
      ),
      backgroundColor: const Color.fromARGB(255, 117, 112, 112),
      body: GameBoard(),
    );
  }
}
