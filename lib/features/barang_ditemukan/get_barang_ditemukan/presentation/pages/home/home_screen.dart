import 'dart:developer';

import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/provider/barang_ditemukan_provider.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/widgets/card_welcome_message.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/widgets/modals_detail_barang_ditemukan_screen.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/widgets/modals_post_barang_ditemukan_screen.dart';
import 'package:provider/provider.dart';

import 'package:benu_app/constant/color.dart';
import 'package:flutter/material.dart';

import '../../widgets/card_barang.dart';

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

  Future<void> _refreshBarangDitemukan() async {
    // Fetch new data from the provider
    await Provider.of<BarangDitemukanProvider>(context, listen: false)
        .fetchBarangDitemukans();
    log("Data refreshed");
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
            return ModalsDetailBarangDitemukanScreen(
                namaBarang: namaBarang,
                imagePath: imagePath,
                namaPenemu: namaPenemu,
                tanggalDitemukan: tanggalDitemukan,
                lokasiDitemukan: lokasiDitemukan,
                profilePicture: profilePicture,
                detail: detail,
                sH: sH,
                sW: sW,
                onKlaimPressed: () {});
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Memastikan fetch dijalankan setelah widget selesai dibangun
      Provider.of<BarangDitemukanProvider>(context, listen: false)
          .fetchBarangDitemukans();
    });
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
          body: RefreshIndicator(
            onRefresh: _refreshBarangDitemukan,
            child: Stack(
              children: [
                Column(
                  children: [
                    //welcome message
                    CardWelcomeMessage(
                      isWelcomeMessageVisible: _isWelcomeMessageVisible,
                      hideWelcomeMessage: _hideWelcomeMessage,
                    ),
                    Consumer<BarangDitemukanProvider>(
                        builder: (context, notifier, child) {
                      if (notifier.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final barangDitemukans = notifier.barangDitemukans;

                      if (barangDitemukans == null ||
                          barangDitemukans.isEmpty) {
                        return const Center(
                          child: Text('No data available'),
                        );
                      }

                      // goods gallery generator

                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: sW * .02),
                          child: GridView.builder(
                            itemCount: barangDitemukans.length,
                            itemBuilder: (_, index) {
                              // Generate new values dynamically for some fields
                              final String namaBarang =
                                  "${barangDitemukans[index].namaBarang} ";
                              final String namaPenemu =
                                  barangDitemukans[index].namaPenemu;
                              final String imagePath =
                                  barangDitemukans[index].imagePath;
                              final String lokasiDitemukan =
                                  barangDitemukans[index].lokasiDitemukan;
                              final String tanggalDitemukan =
                                  barangDitemukans[index].tanggalDitemukan;
                              final String profilePicture =
                                  barangDitemukans[index].profilePicture;
                              final String detail =
                                  barangDitemukans[index].detail;

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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: sW > 600 ? 3 : 2,
                              mainAxisSpacing: sH * .02,
                              crossAxisSpacing: sW * .02,
                              childAspectRatio: 0.8,
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            shape: const CircleBorder(),
            onPressed: () {
              // Show the modal bottom sheet
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                        20), // Customize the modal's rounded corners
                  ),
                ),
                isScrollControlled:
                    true, // Allows the modal to expand dynamically
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    initialChildSize:
                        .9, // Default modal height as a fraction of the screen
                    minChildSize: 0.4, // Minimum modal height
                    maxChildSize: 0.9, // Maximum modal height
                    expand: false,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return ModalsPostBarangDitemukanScreen(
                        namaBarang: "", // Pass empty or dynamic data if needed
                        imagePath: "",
                        namaPenemu: "",
                        tanggalDitemukan: "",
                        lokasiDitemukan: "",
                        // profilePicture: "",
                        detail: "",
                        sH: sH,
                        sW: sW,
                        onSubmitPressed: () {
                          // Handle submit action here
                          log("Item submitted!");
                          Navigator.of(context).pop(); // Close the modal
                        },
                      );
                    },
                  );
                },
              );
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
                      Navigator.of(context).pop;

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
