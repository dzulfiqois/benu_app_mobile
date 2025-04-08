import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/provider/post_barang_ditemukan_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/color.dart';

class ModalsPostBarangDitemukanScreen extends StatefulWidget {
  final String namaBarang;
  final String imagePath;
  final String namaPenemu;
  final String tanggalDitemukan;
  final String lokasiDitemukan;
  // final String profilePicture;
  final String detail;
  final double sH;
  final double sW;
  final VoidCallback onSubmitPressed;

  const ModalsPostBarangDitemukanScreen({
    super.key,
    required this.namaBarang,
    required this.imagePath,
    required this.namaPenemu,
    required this.tanggalDitemukan,
    required this.lokasiDitemukan,
    // required this.profilePicture,
    required this.detail,
    required this.sH,
    required this.sW,
    required this.onSubmitPressed,
  });

  @override
  State<ModalsPostBarangDitemukanScreen> createState() =>
      _ModalsPostBarangDitemukanScreenState();
}

class _ModalsPostBarangDitemukanScreenState
    extends State<ModalsPostBarangDitemukanScreen> {
  late TextEditingController _namaBarangController;
  late TextEditingController _namaPenemuController;
  late TextEditingController _lokasiDitemukanController;
  late TextEditingController _detailController;
  final TextEditingController _tanggalDitemukanController =
      TextEditingController();

  File? _pickedImage;
  String? _imageBase64;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _namaBarangController = TextEditingController();
    _namaPenemuController = TextEditingController();
    _lokasiDitemukanController = TextEditingController();
    _detailController = TextEditingController();
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    _namaPenemuController.dispose();
    _lokasiDitemukanController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final File file = File(image.path);
        final bytes = await file.readAsBytes();
        setState(() {
          _pickedImage = file;
          _imageBase64 = base64Encode(bytes);
        });
        log('Image picked and converted to base64');
      }
    } catch (e) {
      log('Error picking image: $e');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal mengambil gambar. Coba lagi.'),
          ),
        );
      }
    }
  }

  Future<void> _selectTanggalDitemukan() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picker != null) {
      // Format the date to a string
      String formattedDate = picker.toIso8601String();

      // Update the TextField's controller
      _tanggalDitemukanController.text = formattedDate;

      // Notify the provider
      context.read<PostBarangDitemukanProvider>().setTanggalDitemukan(picker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Laporin Temuanmu...',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<PostBarangDitemukanProvider>(
                    builder: (context, notifier, child) {
                      return GestureDetector(
                        onTap: () async {
                          try {
                            final XFile? image = await _imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              final bytes =
                                  await File(image.path).readAsBytes();
                              final base64Image = base64Encode(bytes);

                              setState(() {
                                _pickedImage = File(image.path);
                              });

                              // Call the provider's method to set the image
                              notifier.setGambarBarang(base64Image);

                              log('Image picked and converted to base64: $base64Image');
                            }
                          } catch (e) {
                            log('Error picking image: $e');

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Gagal mengambil gambar. Coba lagi.'),
                                ),
                              );
                            }
                          }
                        },
                        child: SizedBox(
                          height: widget.sH * .3,
                          width: widget.sW,
                          child: _pickedImage != null
                              ? Image.file(
                                  _pickedImage!,
                                  fit: BoxFit.cover,
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.mainColor,
                                      size: widget.sH * .15,
                                    ),
                                    Text(
                                      'Masukkan Foto Barang Temuanmu',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: widget.sH * .015,
                  ),
                  SizedBox(
                    width: widget.sW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Barang',
                          style: GoogleFonts.inter(
                            fontSize: widget.sH * .016,
                          ),
                        ),
                        SizedBox(
                          height: widget.sH * .001,
                        ),
                        Consumer<PostBarangDitemukanProvider>(
                          builder: (context, notifier, child) {
                            return TextField(
                              controller: _namaBarangController,
                              maxLines: 1,
                              style: TextStyle(fontSize: widget.sH * .02),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  hintText: 'Masukkan Nama Barang Temuanmu',
                                  hintStyle: TextStyle(
                                      fontSize: widget.sH * .016,
                                      color: Colors.grey),
                                  hintMaxLines: 1,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 153, 218, 100))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor))),
                              onChanged: (text) {
                                notifier.setNamaBarang(text);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.sH * .015,
                  ),
                  SizedBox(
                    width: widget.sW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Penemu',
                          style: GoogleFonts.inter(
                            fontSize: widget.sH * .016,
                          ),
                        ),
                        SizedBox(
                          height: widget.sH * .001,
                        ),
                        Consumer<PostBarangDitemukanProvider>(
                          builder: (context, notifier, child) {
                            return TextField(
                              controller: _namaPenemuController,
                              maxLines: 1,
                              style: TextStyle(fontSize: widget.sH * .02),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  hintText: 'Masukkan Namamu',
                                  hintStyle: TextStyle(
                                      fontSize: widget.sH * .016,
                                      color: Colors.grey),
                                  hintMaxLines: 1,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 153, 218, 100))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor))),
                              onChanged: (text) {
                                notifier.setNamaPenemu(text);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.sH * .015,
                  ),
                  SizedBox(
                    width: widget.sW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lokasi Ditemukan',
                          style: GoogleFonts.inter(
                            fontSize: widget.sH * .016,
                          ),
                        ),
                        SizedBox(
                          height: widget.sH * .001,
                        ),
                        Consumer<PostBarangDitemukanProvider>(
                          builder: (context, notifier, child) {
                            return TextField(
                              controller: _lokasiDitemukanController,
                              maxLines: 1,
                              style: TextStyle(fontSize: widget.sH * .02),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  hintText: 'Dimana Kamu Nemuin Barang Ini?',
                                  hintStyle: TextStyle(
                                      fontSize: widget.sH * .016,
                                      color: Colors.grey),
                                  hintMaxLines: 1,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 153, 218, 100))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor))),
                              onChanged: (text) {
                                notifier.setLokasiDitemukan(text);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.sH * .015,
                  ),
                  SizedBox(
                    width: widget.sW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tanggal Ditemukan',
                          style: GoogleFonts.inter(
                            fontSize: widget.sH * .016,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: widget.sH * .001,
                        ),
                        Consumer<PostBarangDitemukanProvider>(
                          builder: (context, notifier, child) {
                            return TextField(
                              controller: _tanggalDitemukanController,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontSize: widget.sH * .02,
                              ),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                hintText: 'Tanggal Berapa Nemunya?',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: widget.sH * .016,
                                  color: Colors.grey,
                                ),
                                hintMaxLines: 1,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 153, 218, 100),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.mainColor),
                                ),
                              ),
                              readOnly: true, // Prevent manual editing
                              onTap: () {
                                _selectTanggalDitemukan(); // Open date picker
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.sH * .015,
                  ),
                  SizedBox(
                    width: widget.sW,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Barang Temuanmu',
                          style: GoogleFonts.inter(
                            fontSize: widget.sH * .016,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: widget.sH * .001,
                        ),
                        Consumer<PostBarangDitemukanProvider>(
                          builder: (context, notifier, child) {
                            return TextField(
                              controller: _detailController,
                              maxLines: 3,
                              style: TextStyle(fontSize: widget.sH * .02),
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  hintText: 'Deskripsiin Barang Temuanmu',
                                  hintStyle: TextStyle(
                                      fontSize: widget.sH * .016,
                                      color: Colors.grey),
                                  hintMaxLines: 1,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 153, 218, 100))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.mainColor))),
                              onChanged: (text) {
                                notifier.setDetail(text);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: widget.sH * .03,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log('Submit button pressed');
                      final notifier = Provider.of<PostBarangDitemukanProvider>(
                          context,
                          listen: false);
                      if (notifier.namaBarang.isEmpty ||
                          notifier.namaPenemu.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Pastikan semua kolom terisi.')),
                        );
                      } else {
                        notifier.submitBarangDitemukan();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      foregroundColor: Colors.white,
                      textStyle: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.copy_outlined),
                          SizedBox(width: widget.sW * .03),
                          const Text('Laporin')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.sH * .03,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
