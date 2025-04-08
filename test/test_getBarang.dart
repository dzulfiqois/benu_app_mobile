// ignore_for_file: file_names

import 'dart:developer';

import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/sources/network/network.dart';
import 'package:dio/dio.dart';

void main() async {
  final datasourceId = BarangDitemukanRemoteDatasourceImpl(dio: Dio());

  try {
    final barangDitemukans = await datasourceId.getBarangDitemukan();

    for (var item in barangDitemukans) {
      log('$item\n\n');
    }
  } catch (e) {
    log('error fetching $e');
  }
}
