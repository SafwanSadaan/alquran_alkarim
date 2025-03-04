import 'package:flutter/material.dart';

class ReturnBasmalah extends StatelessWidget {
  const ReturnBasmalah({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Image.asset(
          'assets/basmalah.webp',
          height: 100,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ]),
    );
  }
}
