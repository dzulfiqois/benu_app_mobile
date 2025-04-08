import 'dart:developer';

import 'package:benu_app/core/failure.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/repositories/barang_ditemukan_repository_implementation.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/sources/network/network.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/usecase/get_barang_ditemukan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BarangDitemukanProvider extends ChangeNotifier {
  Failure? failure;
  List<BarangDitemukanEntity>? barangDitemukans;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  BarangDitemukanProvider({
    this.failure,
    this.barangDitemukans,
  });

  Future<void> fetchBarangDitemukans() async {
    try {
      BarangDitemukanRepositoryImplementation repository =
          BarangDitemukanRepositoryImplementation(
              barangDitemukanRemoteDatasource:
                  BarangDitemukanRemoteDatasourceImpl(dio: Dio()));

      _isLoading = true;
      notifyListeners();

      final failureOrBarangDitemukan =
          await GetBarangDitemukan(repository).call();

      failureOrBarangDitemukan.fold(
        (newFailure) {
          barangDitemukans = null;
          failure = newFailure;
          notifyListeners();
        },
        (newBarangDitemukan) {
          barangDitemukans = newBarangDitemukan;
          failure = null;
          notifyListeners();
        },
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      log('ERROR FETCHING DATA $e');
    }
  }
}
