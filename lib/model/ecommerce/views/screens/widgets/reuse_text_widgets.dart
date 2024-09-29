import 'package:flutter/material.dart';

class ReuseTextWidget extends StatelessWidget {
  final String title;
  const ReuseTextWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 21, letterSpacing: 4),
      ),
    );
  }
}
