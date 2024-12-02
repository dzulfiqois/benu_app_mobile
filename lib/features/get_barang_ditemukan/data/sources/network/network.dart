import 'dart:convert';
import 'dart:developer';

import 'package:benu_app/constant/constant.dart';
import 'package:benu_app/features/get_barang_ditemukan/data/dto/barang_ditemukan_dto.dart';
import 'package:benu_app/features/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
import 'package:dio/dio.dart';

import '../../../../../constant/exception.dart';

abstract class BarangDitemukanRemoteDatasource {
  Future<List<BarangDitemukanEntity>> getBarangDitemukan();
}

class BarangDitemukanRemoteDatasourceImpl
    implements BarangDitemukanRemoteDatasource {
  final dio = Dio();

  @override
  Future<List<BarangDitemukanEntity>> getBarangDitemukan() async {
    try {
      log('fetching data starting. trying to get data from api');

      final barangDitemukanResponse = await dio.get(DATA_URL);
      // log(barangDitemukanResponse.toString());

      log('fetching data done.');

      if (barangDitemukanResponse.statusCode == 200) {
        var barangDitemukanData = barangDitemukanResponse.data is String
            ? jsonDecode(barangDitemukanResponse.data)
            : barangDitemukanResponse.data;

        List<BarangDitemukanDto> barangDitemukanList = barangDitemukanData
            .map<BarangDitemukanDto>((json) => BarangDitemukanDto.fromMap(json))
            .toList();

        // log('fetched dataset = $barangDitemukanList');

        return barangDitemukanList;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw Exception('Error fetching data $e');
    }
  }
}
