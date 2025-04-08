import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/repository/barang_ditemukan_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/failure.dart';
import '../entity/barang_ditemukan_entity.dart';

class GetBarangDitemukan {
  final BarangDitemukanRepository barangDitemukanRepository;

  GetBarangDitemukan(this.barangDitemukanRepository);

  Future<Either<Failure, List<BarangDitemukanEntity>>> call() async {
    return await barangDitemukanRepository.getBarangDitemukan();
  }
}
