import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  final String text;

  @override

  Widget build(context) {
  return const Text(
              "hello world!!",
              style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 214, 241, 255)),

            );
  }

}