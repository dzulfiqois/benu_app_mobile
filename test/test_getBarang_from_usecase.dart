// ignore_for_file: file_names

import 'dart:developer';

import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/repositories/barang_ditemukan_repository_implementation.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/sources/network/network.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/usecase/get_barang_ditemukan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // fetch from network sourcFe
  final datasourceId = BarangDitemukanRemoteDatasourceImpl(dio: Dio());
  //injecting into domain.repository
  final repository = BarangDitemukanRepositoryImplementation(
      barangDitemukanRemoteDatasource: datasourceId);
  // create usecase
  final getBarangDitemukan = GetBarangDitemukan(repository);

  try {
    //call usecase
    final result = await getBarangDitemukan.call();

    //handling the result
    result.fold((failure) => log('usecase failed : ${failure.errorMessage}'),
        (barangDitemukans) {
      log('usecase success');
      for (var item in barangDitemukans) {
        log('$item');
      }
    });
  } catch (e) {
    log('error fetching $e');
  }
}
