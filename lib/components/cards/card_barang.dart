import 'package:benu_app/components/misc/spacers.dart';
import 'package:benu_app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBarang extends StatelessWidget {
  final double sW;
  final double sH;
  final VoidCallback onTap;
  final String namaBarang;
  final String namaPenemu;
  final String imagePath;
  final String detail;
  final String lokasiDitemukan;
  final String tanggalDitemukan;
  final String profilePicture;

  const CardBarang({
    super.key,
    required this.sW,
    required this.sH,
    required this.onTap,
    required this.namaBarang,
    required this.namaPenemu,
    required this.imagePath,
    required this.detail,
    required this.lokasiDitemukan,
    required this.tanggalDitemukan,
    required this.profilePicture,
  });

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
            color: AppColors.backgroundAccent,
            borderRadius: BorderRadius.circular(sH * .015),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section with proper aspect ratio
              AspectRatio(
                aspectRatio: 1.3, // Aspect ratio to maintain image proportions
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Ensure the image fills the space
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: sH * .0),
                    child: Text(
                      namaBarang,
                      style: GoogleFonts.inter(
                        // crossAxisCount: sW > 600 ? 3: 2
                        fontSize: sW > 700 ? sH * .03 : sH * .014,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: sW > 700 ? sH * .03 : sH * .014,
                    ),
                  ),
                  SizedBox(
                    height: sH * .02,
                  )
                ],
              ),
              Spacers(sH: sH * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sW * .005),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: sW > 700 ? sH * .075 : sH * .04,
                      width: sW > 700 ? sH * .075 : sH * .04,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(profilePicture),
                      ),
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.mainColor,
                      size: sW > 700 ? sH * .075 : sH * .03,
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
