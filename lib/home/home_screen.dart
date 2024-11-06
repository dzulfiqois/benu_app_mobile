import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  @override
  Widget build(BuildContext context) {
    double sW = MediaQuery.of(context).size.width;
    double sH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(80.0), // Adjust the height as needed
        child: AppBar(
          leadingWidth: 80,
          backgroundColor: const Color(0xff006769),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.only(left: 10, right: 5, top: 5),
            child: const CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/profile_image.png'), // Replace with your image asset path
            ),
          ),
          title: SizedBox(
            width: sW * .6,
            // width: 300,
            child: Text(
              "Hi, Izi!",
              textAlign: TextAlign.left,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              //search bar
              Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
                child: SizedBox(
                  height: sH * .075,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffeeeeee),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Image.asset("assets/images/search_icon.png"),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Temukan barang kamu!",
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: const Color(0xffbbbbbb),
                                ),
                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //welcome message
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInBack,
                child: AnimatedOpacity(
                  opacity: _isWelcomeMessageVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: _isWelcomeMessageVisible
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 4, top: 0),
                          child: SizedBox(
                            height: sH * .175,
                            // decoration: BoxDecoration(border: Border.all()),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: sW,
                                decoration: BoxDecoration(
                                  color: const Color(0xff006769),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Belum Nemu adalah aplikasi pencarian\nbarang hilang yang memudahkan anda\nuntuk menemukan benda berharga yang\nhilang',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          letterSpacing: 1),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 75.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              _hideWelcomeMessage();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Oke',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              //goods gallery generator
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    child: GridView.builder(
                      itemCount: 15,
                      itemBuilder: (_, index) => const CardBarang(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: .75),
                    ),
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(border: Border.all()),
              ),
            ],
          ),

          // report button
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      const phoneNumber = '6283836100924';
                      const message = 'Halo, mau lapor nih saya nemuin barang.';
                      final whatsAppLink =
                          'http:/wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

                      if (await canLaunchUrlString(whatsAppLink)) {
                        await launchUrlString(whatsAppLink);
                      } else {
                        // Handle the error, like showing a snackbar or alert dialog
                        log('Could not open WhatsApp.');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff25d366),
                          borderRadius: BorderRadius.circular(100)),
                      width: sW * .9,
                      height: sH * .065,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/whatsapp_logo-removebg.png',
                            color: Colors.white,
                          ),
                          Text(
                            'Nemuin barang? Laporin disini',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CardBarang extends StatelessWidget {
  const CardBarang({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      child: Column(
        children: [
          Image.asset(
            'assets/images/barang1.png',
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kamera Canon',
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                'Ditemukan di toilet kantin',
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/images/profile_image.png'), // Replace with your image asset path
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.location_on,
                        size: 45,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
