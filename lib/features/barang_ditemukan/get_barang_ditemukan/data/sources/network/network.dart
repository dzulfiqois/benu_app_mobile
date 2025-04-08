import 'dart:convert';
import 'dart:developer';

import 'package:benu_app/constant/constant.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/dto/barang_ditemukan_dto.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
import 'package:dio/dio.dart';

import '../../../../../../constant/exception.dart';

abstract class BarangDitemukanRemoteDatasource {
  Future<List<BarangDitemukanEntity>> getBarangDitemukan();
  Future<void> postBarangDitemukan(BarangDitemukanEntity barangDitemukan);
}

class BarangDitemukanRemoteDatasourceImpl
    implements BarangDitemukanRemoteDatasource {
  final Dio dio;

  BarangDitemukanRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<BarangDitemukanEntity>> getBarangDitemukan() async {
    try {
      log('fetching data starting. trying to get data from api');

      final barangDitemukanResponse = await dio.get(DATA_URL);

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

  @override
  Future<void> postBarangDitemukan(
      BarangDitemukanEntity barangDitemukan) async {
    final barangDitemukanDto = BarangDitemukanDto.fromEntity(barangDitemukan);

    final response = await dio.post(DATA_URL,
        data: barangDitemukanDto.toMap(),
        options: Options(headers: {'Content-Type': 'application/json'}));

    log("log on network: $response.toString()");

    if (response.statusCode != 200) {
      throw Exception('Failed to send data');
    }
  }
}
