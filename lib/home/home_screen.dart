import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cardbarang.dart';

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

  void _showDetailsModal(String title, String description, String imagePath) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Image.asset(imagePath, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(
                description,
                style: GoogleFonts.inter(fontSize: 16),
              ),
            ],
          ),
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
              backgroundColor: const Color(0xff006769),
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
                      child: SizedBox(
                          child: GridView.builder(
                        itemCount: 15,
                        itemBuilder: (_, index) => CardBarang(
                          sH: sH,
                          sW: sW,
                          onTap: () {
                            _showDetailsModal(
                              'Kamera Canon $index',
                              'Ditemukan di toilet kantin $index',
                              'assets/images/barang1.png',
                            );
                          },
                          title: 'Kamera Canon $index',
                          description: 'Ditemukan di toilet kantin $index',
                          imagePath: 'assets/images/barang1.png',
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: sH * .02,
                          crossAxisSpacing: sW * .02,
                          childAspectRatio: sW / (sH * .6),
                        ),
                      )),
                    ),
                  ),
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
