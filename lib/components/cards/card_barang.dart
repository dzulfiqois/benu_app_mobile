import 'package:benu_app/components/misc/spacers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBarang extends StatelessWidget {
  const CardBarang({
    super.key,
    required this.sW,
    required this.sH,
    required this.onTap,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  final double sW;
  final double sH;
  final VoidCallback onTap;
  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the callback when the card is pressed
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          sW * .02,
          sH * .015,
          sW * .02,
          0,
        ),
        child: Container(
          padding: EdgeInsets.all(sH * .007),
          // Maintain a fixed aspect ratio for the card
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(sH * .015),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Section with proper aspect ratio
              AspectRatio(
                aspectRatio: 1.3, // Aspect ratio to maintain image proportions
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Ensure the image fills the space
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: sH * .01),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: sH * .016,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: sH * .014,
                ),
              ),
              Spacers(sH: sH * 0.01), // Spacer for visual separation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sW * .005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: sH * .02,
                      backgroundColor: Colors.purple,
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: const Color(0xff006769),
                      size: sH * .03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
