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
    required String title,
    required String description,
    required String imagePath,
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
                    title,
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
                                  const CircleAvatar(),
                                  SizedBox(
                                    width: sW * .025,
                                  ),
                                  Text(
                                    'Marsel Hendrayana',
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
                              // Container(
                              //   height: sH * .04,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(sH * .02),
                              //     color: AppColors.secondaryColor,
                              //   ),
                              //   child: FittedBox(
                              //     fit: BoxFit.scaleDown,
                              //     child: Padding(
                              //       padding: EdgeInsets.symmetric(
                              //           horizontal: sH * .02),
                              //       child: Text(
                              //         'Klaim',
                              //         style: GoogleFonts.inter(
                              //           fontSize: sH * .018,
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                                  '2024-01-01',
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
                                  'Disekitar tempat terakhir kita bersapa walau itu hanya kata perpisahan.',
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
                                height: sH * .175,
                                width: sW,
                                decoration: BoxDecoration(
                                  color: const Color(0xff006769),
                                  borderRadius: BorderRadius.circular(sH * .02),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Belum Nemu adalah aplikasi pencarian\nbarang hilang yang memudahkan anda\nuntuk menemukan benda berharga yang\nhilang',
                                      style: GoogleFonts.inter(
                                          fontSize: sH * .014,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sW * .15),
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
                        itemCount: 15,
                        itemBuilder: (_, index) => CardBarang(
                          sH: sH,
                          sW: sW,
                          onTap: () {
                            _showDetailsModal(
                              sH: sH,
                              sW: sW,
                              title: 'Kamera Canon $index',
                              description: 'Ditemukan di toilet kantin $index',
                              imagePath: 'assets/images/barang1.png',
                            );
                          },
                          title: 'Kamera $index',
                          description: 'Ditemukan di toilet kantin $index',
                          imagePath: 'assets/images/barang1.png',
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: sW > 600
                              ? 3
                              : 2, // Adjust columns based on screen width
                          mainAxisSpacing: sH * .02,
                          crossAxisSpacing: sW * .02,
                          childAspectRatio:
                              0.8, // Adjust the aspect ratio of the grid item
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
            backgroundColor: const Color(0xff006769),
            shape: const CircleBorder(),
            onPressed: () {},
            child: Icon(
              size: sH * .045,
              Icons.add,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: sH * .1,
                  child: IconButton(
                    onPressed: () {},
                    iconSize: sH * .04,
                    icon: const Icon(
                      Icons.home,
                    ),
                    tooltip: 'Home',
                    color: const Color(0xff006769),
                  ),
                ),
                SizedBox(
                  height: sH * .1,
                  child: IconButton(
                    onPressed: () {},
                    iconSize: sH * .04,
                    icon: const Icon(
                      Icons.settings,
                    ),
                    tooltip: 'Home',
                    color: const Color(0xff006769),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}



// Map<String, dynamic> data = {
//   "nama_penemu": "Marsel Hendrayana",
//   "profile_picture": "assets/images/profile_image.png",
//   "tanggal_ditemukan": "22-11-2025",
//   "lokasi_ditemukan":
//       "Disekitar tempat terakhir kita bersapa walau itu hanya kata perpisahan.",
//   "detail": [
//     "Kamera Baru",
//     "Jenis Canon XII",
//     "Full Set dengan Tas",
//     "Terdapat goresan pada mounting"
//   ],
//   "image": 'assets/images/barang1.png',
// };
