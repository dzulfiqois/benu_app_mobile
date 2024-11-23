// import 'package:benu_app/components/misc/spacers.dart';
import 'dart:developer';

import 'package:benu_app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:benu_app/dummy/dataset.dart';
import '../components/misc/label.dart';
import '../components/cards/card_barang.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isWelcomeMessageVisible = true;

  void _hideWelcomeMessage() {
    setState(() {
      _isWelcomeMessageVisible = false;
    });
  }

  void _showDetailsModal({
    required String namaBarang,
    required String imagePath,
    required String namaPenemu,
    required String tanggalDitemukan,
    required String lokasiDitemukan,
    required String profilePicture,
    required String detail,
    required double sH,
    required double sW,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(sH * .02)), // Rounded corners
      ),
      isScrollControlled: true, // Allows the modal to expand dynamically
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize:
              0.6, // Default modal height as a fraction of the screen
          minChildSize: 0.4, // Minimum modal height
          maxChildSize: 0.9, // Maximum modal height
          expand: false,
          builder: (_, scrollController) {
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
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: sH * .01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: AssetImage(profilePicture),
                                  ),
                                  SizedBox(
                                    width: sW * .025,
                                  ),
                                  Text(
                                    namaPenemu,
                                    style: GoogleFonts.inter(
                                        fontSize: sH * .018,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  log('message');
                                },
                                child: Label(
                                    sH: sH,
                                    sW: sW,
                                    labelColor: AppColors.secondaryColor,
                                    labelText: 'Klaim'),
                              )
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
                                    horizontal: sW * .01, vertical: sH * .01),
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
                                    horizontal: sW * .01, vertical: sH * .01),
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
                                    horizontal: sW * .01, vertical: sH * .01),
                                child: Text(
                                  'Disekitar tempat terakhir kita bersapa walau itu hanya kata perpisahan.',
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
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(sH * .075), // Adjust the height as needed
            child: AppBar(
              backgroundColor: AppColors.mainColor,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              title: Container(
                margin: EdgeInsets.only(top: sH * .015),
                height: sH * .04,
                child: Image.asset(
                  'assets/images/benu_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              centerTitle: true,
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  //welcome message
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInBack,
                    child: AnimatedOpacity(
                      opacity: _isWelcomeMessageVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: _isWelcomeMessageVisible
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(
                                sW * .02,
                                sH * .03,
                                sW * .02,
                                sH * .015,
                              ),
                              child: Container(
                                height: sW > 700 ? sH * .25 : sH * .175,
                                width: sW,
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(sH * .02),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Belum Nemu adalah aplikasi pencarian\nbarang hilang yang memudahkan anda\nuntuk menemukan benda berharga yang\nhilang',
                                      style: GoogleFonts.inter(
                                          fontSize:
                                              sW > 600 ? sH * .03 : sH * .014,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              sW > 700 ? sW * .3 : sW * .15),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _hideWelcomeMessage();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        sH * .01),
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(sH * .008),
                                                child: Text(
                                                  'OK',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),

                  // goods gallery generator
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: sW * .02),
                      child: GridView.builder(
                        itemCount: 15, // Duplicates the single data
                        itemBuilder: (_, index) {
                          // Generate new values dynamically for some fields
                          final String namaBarang =
                              "${dummyData['nama_barang']} ";
                          final String namaPenemu = dummyData['nama_penemu'];
                          final String imagePath = dummyData['image_path'];
                          final String lokasiDitemukan =
                              dummyData['lokasi_ditemukan'];
                          final String tanggalDitemukan =
                              dummyData['tanggal_ditemukan'];
                          final String profilePicture =
                              dummyData['profile_picture'];
                          final String detail =
                              (dummyData['detail'] as List<dynamic>).join(', ');

                          return CardBarang(
                            sW: sW,
                            sH: sH,
                            namaBarang: namaBarang,
                            namaPenemu: namaPenemu,
                            imagePath: imagePath,
                            detail: detail,
                            lokasiDitemukan: lokasiDitemukan,
                            tanggalDitemukan: tanggalDitemukan,
                            profilePicture: profilePicture,
                            onTap: () {
                              _showDetailsModal(
                                sH: sH,
                                sW: sW,
                                namaBarang: namaBarang,
                                imagePath: imagePath,
                                namaPenemu: namaPenemu,
                                tanggalDitemukan: tanggalDitemukan,
                                lokasiDitemukan: lokasiDitemukan,
                                detail: detail,
                                profilePicture: profilePicture,
                              );
                            },
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: sW > 600 ? 3 : 2,
                          mainAxisSpacing: sH * .02,
                          crossAxisSpacing: sW * .02,
                          childAspectRatio: 0.8,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            shape: const CircleBorder(),
            onPressed: () {
              log('Add Item');
            },
            child: Icon(
              size: sW > 700 ? sH * .075 : sH * .04,
              Icons.add,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppColors.backgroundAccent,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: sH * .1,
                  child: IconButton(
                    onPressed: () {
                      log('Home');
                    },
                    iconSize: sW > 700 ? sH * .075 : sH * .04,
                    icon: const Icon(
                      Icons.home,
                    ),
                    tooltip: 'Home',
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(
                  height: sH * .1,
                  child: IconButton(
                    onPressed: () {
                      log('Setting');
                    },
                    iconSize: sW > 700 ? sH * .075 : sH * .04,
                    icon: const Icon(
                      Icons.settings,
                    ),
                    tooltip: 'Setting',
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

final Map<String, dynamic> dummyData = {
  "nama_penemu": "Marsel Hendrayana",
  "nama_barang": "Kamera Canon",
  "profile_picture": "assets/images/profile_image.png",
  "tanggal_ditemukan": "01-01-2024",
  "lokasi_ditemukan":
      "Disekitar tempat terakhir kita bersapa walau itu hanya kata perpisahan.",
  "detail": [
    "Kamera Baru",
    "Jenis Canon XII",
    "Full Set dengan Tas",
    "Terdapat goresan pada mounting"
  ],
  "image_path": 'assets/images/barang1.png',
};
