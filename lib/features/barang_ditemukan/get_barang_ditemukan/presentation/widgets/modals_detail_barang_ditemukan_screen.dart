import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../components/misc/label.dart';
import '../../../../../constant/color.dart';

Future<void> _dialogKlaimBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext content) {
      return AlertDialog(
        title: Text(
          "Klaim Barang Ini?",
          style: GoogleFonts.inter(fontSize: 18),
        ),
        content: Text(
          'Dengan ngeklik ya, kamu dianggap menjadi pemilik barang ini. Namun ketika bukan, akan kami proses secara hukum yang berlaku.',
          style: GoogleFonts.inter(),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Tidak, bukan barang saya'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ya, Ini barang saya!'),
            onPressed: () async {
              Navigator.of(context).pop(); // Close the current screen
              await _klaim(); // Await the async function
            },
          ),
        ],
      );
    },
  );
}

Future<void> _klaim() async {
  var contactUrl = Uri.parse('https://wa.me/628817084832'); // Correct format

  if (!await launchUrl(contactUrl, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch the URL.');
  }
}

class ModalsDetailBarangDitemukanScreen extends StatelessWidget {
  final String namaBarang;
  final String imagePath; // Can be a link or Base64 string
  final String namaPenemu;
  final String tanggalDitemukan;
  final String lokasiDitemukan;
  final String profilePicture;
  final String detail;
  final double sH;
  final double sW;
  final VoidCallback onKlaimPressed;

  const ModalsDetailBarangDitemukanScreen({
    super.key,
    required this.namaBarang,
    required this.imagePath,
    required this.namaPenemu,
    required this.tanggalDitemukan,
    required this.lokasiDitemukan,
    required this.profilePicture,
    required this.detail,
    required this.sH,
    required this.sW,
    required this.onKlaimPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sticky title at the top
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            namaBarang,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Scrollable content below the title
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  _buildImage(imagePath),
                  SizedBox(height: sH * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(profilePicture),
                          ),
                          SizedBox(
                            width: sW * .025,
                          ),
                          Text(
                            namaPenemu,
                            style: GoogleFonts.inter(
                              fontSize: sH * .018,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          log('message');
                          _dialogKlaimBuilder(context);
                        },
                        child: Label(
                          sH: sH,
                          sW: sW,
                          labelColor: AppColors.secondaryColor,
                          labelText: 'Klaim',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sH * .01),
                  Divider(
                    height: sH * .01,
                    color: const Color(0xffd9d9d9),
                    thickness: 5,
                  ),
                  SizedBox(height: sH * .01),

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(
                        sH: sH,
                        sW: sW,
                        labelText: 'Tanggal Ditemukan',
                        labelColor: AppColors.mainColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: sW * .01,
                          vertical: sH * .01,
                        ),
                        child: Text(
                          tanggalDitemukan,
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(
                        sH: sH,
                        sW: sW,
                        labelText: 'Lokasi Ditemukan',
                        labelColor: AppColors.mainColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: sW * .01,
                          vertical: sH * .01,
                        ),
                        child: Text(
                          lokasiDitemukan,
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(
                        sH: sH,
                        sW: sW,
                        labelText: 'Detail',
                        labelColor: AppColors.mainColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: sW * .01,
                          vertical: sH * .01,
                        ),
                        child: Text(
                          detail,
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sH * .01),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to display the image
  Widget _buildImage(String path) {
    final isBase64 = RegExp(r'^[A-Za-z0-9+/]+={0,2}$').hasMatch(path);

    if (isBase64) {
      try {
        final decodedBytes = base64Decode(path);
        return Image.memory(
          decodedBytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 50);
          },
        );
      } catch (e) {
        return const Icon(Icons.broken_image, size: 50);
      }
    } else {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 50);
        },
      );
    }
  }
}
