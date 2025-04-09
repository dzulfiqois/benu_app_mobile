import 'dart:developer';

import 'package:flutter/material.dart';

import '../../domain/entity/barang_ditemukan_entity.dart';
import '../../domain/usecase/post_barang_ditemukan.dart';

class PostBarangDitemukanProvider extends ChangeNotifier {
  final PostBarangDitemukan postBarangDitemukan;

  // Constructor to inject the use case
  PostBarangDitemukanProvider(this.postBarangDitemukan);

  String _namaBarang = '';
  String _namaPenemu = '';
  String _lokasiDitemukan = '';
  String _tanggalDitemukan = '';
  String _detail = '';
  String _gambarBarang = '';
  String? _errorMessage;
  bool _isLoading = false;

  // Getters
  String get namaBarang => _namaBarang;
  String get namaPenemu => _namaPenemu;
  String get lokasiDitemukan => _lokasiDitemukan;
  String get tanggalDitemukan => _tanggalDitemukan;
  String get detail => _detail;
  String get gambarBarang => _gambarBarang;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void setNamaBarang(String namaBarang) {
    _namaBarang = namaBarang;
    notifyListeners();
  }

  void setNamaPenemu(String namaPenemu) {
    _namaPenemu = namaPenemu;
    notifyListeners();
  }

  void setLokasiDitemukan(String lokasiDitemukan) {
    _lokasiDitemukan = lokasiDitemukan;
    notifyListeners();
  }

  void setTanggalDitemukan(DateTime tanggalDitemukan) {
    _tanggalDitemukan = tanggalDitemukan.toIso8601String();
    log('Tanggal ditemukan set to: $_tanggalDitemukan');
    notifyListeners();
  }

  void setDetail(String detail) {
    _detail = detail;
    notifyListeners();
  }

  void setGambarBarang(String gambarBarang) {
    _gambarBarang = gambarBarang;
    notifyListeners();
  }

  Future<bool> submitBarangDitemukan() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Create the entity with data
      final barangDitemukanEntity = BarangDitemukanEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        namaBarang: _namaBarang,
        namaPenemu: _namaPenemu,
        tanggalDitemukan: _tanggalDitemukan, // Pass the String value
        lokasiDitemukan: _lokasiDitemukan,
        detail: _detail,
        imagePath: _gambarBarang,
        profilePicture: 'profile picture', // placeholder
        createdAt: DateTime.now().toIso8601String(),
      );

      log(barangDitemukanEntity.toString());
      log('Tanggal ditemukan during submission: $_tanggalDitemukan');

      final result = await postBarangDitemukan.post(barangDitemukanEntity);

      return result.fold(
        (failure) {
          _errorMessage = failure.errorMessage;
          log('Failed to submit barang ditemukan: $_errorMessage');
          return false;
        },
        (barang) {
          log('Successfully submitted barang ditemukan');
          return true;
        },
      );
    } catch (e) {
      _errorMessage = 'Unexpected error occurred: $e';
      log(_errorMessage!);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> submitBarangDitemukan() async {
  //   _isLoading = true;
  //   _errorMessage = null;
  //   notifyListeners();

  //   try {
  //     // Create the entity with data
  //     final barangDitemukanEntity = BarangDitemukanEntity(
  //       id: DateTime.now().millisecondsSinceEpoch.toString(),
  //       namaBarang: _namaBarang,
  //       namaPenemu: _namaPenemu,
  //       tanggalDitemukan: _tanggalDitemukan, // Pass the String value
  //       lokasiDitemukan: _lokasiDitemukan,
  //       detail: _detail,
  //       imagePath: _gambarBarang,
  //       profilePicture: 'profile picture', // placeholder
  //       createdAt: DateTime.now().toIso8601String(),
  //     );

  //     log(barangDitemukanEntity.toString());
  //     log('Tanggal ditemukan during submission: $_tanggalDitemukan');
  //     final result = await postBarangDitemukan.post(barangDitemukanEntity);

  //     result.fold(
  //       (failure) {
  //         _errorMessage = failure.errorMessage;
  //         log('Failed to submit barang ditemukan: $_errorMessage');
  //       },
  //       (barang) {
  //         log('Successfully submitted barang ditemukan');
  //       },
  //     );
  //   } catch (e) {
  //     _errorMessage = 'Unexpected error occurred: $e';
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}

// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import '../../../../../constant/constant.dart';

// class PostBarangDitemukanProvider extends ChangeNotifier {
//   PostBarangDitemukanProvider(this.postBarangDitemukan);

//   String _namaBarang = '';
//   String _namaPenemu = '';
//   String _lokasiDitemukan = '';
//   String _tanggalDitemukan = '';
//   String _detail = '';
//   String _gambarBarang = '';
//   String? _errorMessage;
//   bool _isLoading = false;

//   String get namaBarang => _namaBarang;
//   String get namaPenemu => _namaPenemu;
//   String get lokasiDitemukan => _lokasiDitemukan;
//   String get tanggalDitemukan => _tanggalDitemukan;
//   String get detail => _detail;
//   String get gambarBarang => _gambarBarang;
//   String? get errorMessage => _errorMessage;
//   bool get isLoading => _isLoading;

//   void setNamaBarang(String namaBarang) {
//     _namaBarang = namaBarang;
//     notifyListeners();
//   }

//   void setNamaPenemu(String namaPenemu) {
//     _namaPenemu = namaPenemu;
//     notifyListeners();
//   }

//   void setLokasiDitemukan(String lokasiDitemukan) {
//     _lokasiDitemukan = lokasiDitemukan;
//     notifyListeners();
//   }

//   void setTanggalDitemukan(String tanggalDitemukan) {
//     _tanggalDitemukan = tanggalDitemukan;
//     notifyListeners();
//   }

//   void setDetail(String detail) {
//     _detail = detail;
//     notifyListeners();
//   }

//   void setGambarBarang(String gambarBarang) {
//     _gambarBarang = gambarBarang;
//     notifyListeners();
//   }

//   Future<void> submitBarangDitemukan() async {
//     final dio = Dio();
//     final error = validate();
//     if (error != null) {
//       _errorMessage = error;
//       notifyListeners();
//       return;
//     }

//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       final dataBarangDitemukan = {
//         'nama_barang': _namaBarang,
//         'nama_penemu': _namaPenemu,
//         'lokasi_ditemukan': _lokasiDitemukan,
//         'tanggal_ditemukan': _tanggalDitemukan,
//         'detail': _detail,
//         'gambar_barang': _gambarBarang,
//       };

//       // Perform API call here (uncomment Dio implementation)
//       final response = await dio.post(DATA_URL, data: dataBarangDitemukan);
//       log(response.toString());
//     } catch (e) {
//       _errorMessage = 'Gagal mengirim data: $e';
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   String? validate() {
//     if (_namaBarang.isEmpty) return 'Nama barang harus diisi';
//     if (_namaPenemu.isEmpty) return 'Nama penemu harus diisi';
//     if (_lokasiDitemukan.isEmpty) return 'Lokasi harus diisi';
//     return null;
//   }

//   void reset() {
//     _namaBarang = '';
//     _namaPenemu = '';
//     _lokasiDitemukan = '';
//     _tanggalDitemukan = '';
//     _detail = '';
//     _gambarBarang = '';
//     _errorMessage = null;
//     _isLoading = false;
//     notifyListeners();
//   }
// }
