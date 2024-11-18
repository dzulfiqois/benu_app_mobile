import 'package:benu_app/components/misc/spacer.dart';
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
          height: sH * .25,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(sH * .015),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.inter(
                      fontSize: sH * .014, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: sH * .014,
                  ),
                ),
                Spacers(sH: sH),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sW * .005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: sH * .04,
                        child: const CircleAvatar(
                          backgroundColor: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: sH * .04,
                        child: const FittedBox(
                          fit: BoxFit.cover,
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff006769),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
