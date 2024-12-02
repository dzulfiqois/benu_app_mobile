import 'package:dartz/dartz.dart';

import '../../../../core/failure.dart';
import '../entity/barang_ditemukan_entity.dart';

abstract class BarangDitemukanRepository {
  Future<Either<Failure, List<BarangDitemukanEntity>>> getBarangDitemukan();
}
