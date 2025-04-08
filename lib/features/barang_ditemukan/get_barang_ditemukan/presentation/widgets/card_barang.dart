import 'dart:convert';

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
  final String imagePath; // Can be URL or Base64 string
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
                child: _buildImage(imagePath), // Use helper method for image
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
                        backgroundImage: NetworkImage(profilePicture),
                      ),
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.mainColor,
                      size: sW > 700 ? sH * .075 : sH * .04,
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

  /// Helper method to build the image widget
  Widget _buildImage(String path) {
    // Check if `path` is Base64 encoded
    final isBase64 = RegExp(r'^[A-Za-z0-9+/]+={0,2}$').hasMatch(path);

    if (isBase64) {
      // Decode Base64 string and display it
      try {
        final decodedBytes = base64Decode(path);
        return Image.memory(
          decodedBytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return  Icon(Icons.broken_image, size: 50);
          },
        );
      } catch (e) {
        return  Icon(Icons.broken_image, size: 50);
      }
    } else {
      // Assume it's a URL and display it
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return  Icon(Icons.broken_image, size: 50);
        },
      );
    }
  }
}
