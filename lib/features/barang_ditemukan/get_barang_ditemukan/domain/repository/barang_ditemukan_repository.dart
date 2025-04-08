import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../entity/barang_ditemukan_entity.dart';

abstract class BarangDitemukanRepository {
  //fetching barang ditemukan
  Future<Either<Failure, List<BarangDitemukanEntity>>> getBarangDitemukan();

  //posting barang ditemukan
  Future<Either<Failure, BarangDitemukanEntity>> postBarangDitemukan(
      BarangDitemukanEntity barangDitemukan);
}
