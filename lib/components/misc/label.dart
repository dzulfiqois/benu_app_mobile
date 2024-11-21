import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Label extends StatelessWidget {
  const Label({
    required this.sH,
    required this.sW,
    required this.labelColor,
    required this.labelText,
    super.key,
  });

  final double sW;
  final double sH;
  final String labelText;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sH * .04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sH * .02),
        color: labelColor,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sH * .02),
          child: Text(
            labelText,
            style: GoogleFonts.inter(
              fontSize: sH * .018,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
