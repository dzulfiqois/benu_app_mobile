import 'package:benu_app/core/failure.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/sources/network/network.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/repository/barang_ditemukan_repository.dart';
import 'package:dartz/dartz.dart';

class BarangDitemukanRepositoryImplementation
    extends BarangDitemukanRepository {
  final BarangDitemukanRemoteDatasource barangDitemukanRemoteDatasource;

  BarangDitemukanRepositoryImplementation({
    required this.barangDitemukanRemoteDatasource,
  });

  @override
  Future<Either<Failure, List<BarangDitemukanEntity>>>
      getBarangDitemukan() async {
    try {
      final data = await barangDitemukanRemoteDatasource.getBarangDitemukan();
      return Right(data);
    } catch (e) {
      return const Left(Failure(errorMessage: 'Failed to fetch data'));
    }
  }

  @override
  Future<Either<Failure, BarangDitemukanEntity>> postBarangDitemukan(
    BarangDitemukanEntity barangDitemukan,
  ) async {
    try {
      await barangDitemukanRemoteDatasource
          .postBarangDitemukan(barangDitemukan);
      return Right(barangDitemukan);
    } catch (e) {
      return Left(Failure(errorMessage: 'Failed to post data'));
    }
  }
}
