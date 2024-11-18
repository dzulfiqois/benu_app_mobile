import 'package:flutter/material.dart';

class Spacers extends StatelessWidget {
  const Spacers({
    super.key,
    required this.sH,
  });

  final double sH;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sH * .015,
    );
  }
}
