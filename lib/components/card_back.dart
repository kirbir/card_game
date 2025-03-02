import 'package:flutter/material.dart';
import 'package:card_game/constants.dart';

class CardBack extends StatelessWidget {
  final double size;
  final Widget? child;

  const CardBack({super.key, this.size = 1, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CARD_WIDTH * size,
      height: CARD_HEIGHT * size,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 53, 67, 255),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child ?? Container(),
    );
  }
}
