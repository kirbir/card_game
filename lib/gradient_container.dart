import 'package:flutter/material.dart';


class GradientSection extends StatelessWidget {
   const GradientSection(
    this.colorStart,
    this.colorEnd, {
    super.key,
  });

  final Color colorStart;
  final Color colorEnd;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorStart, colorEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
    
      ),
    );
  }
}

