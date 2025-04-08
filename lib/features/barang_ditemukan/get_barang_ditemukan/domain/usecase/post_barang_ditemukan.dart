import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../../../get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
import '../repository/barang_ditemukan_repository.dart';

class PostBarangDitemukan {
  final BarangDitemukanRepository barangDitemukanRepository;

  PostBarangDitemukan(this.barangDitemukanRepository);

  Future<Either<Failure, BarangDitemukanEntity>> post(
      BarangDitemukanEntity barangDitemukan) async {
    try {
      await barangDitemukanRepository.postBarangDitemukan(barangDitemukan);
      log(barangDitemukanRepository.toString());
      return Right(barangDitemukan);
    } catch (e) {
      return Left(Failure(errorMessage: 'errorMessage $e'));
    }

    // try {
    //   final result =
    //       await barangDitemukanRepository.postBarangDitemukan(barangDitemukan);
    //   log('Data: $result');
    //   log('Successfully posted barang ditemukan');
    //   return Right(barangDitemukan);
    // } catch (e) {
    //   log('Error posting data: $e');
    //   return const Left(Failure(errorMessage: 'Error posting data'));
    // }
  }
}
