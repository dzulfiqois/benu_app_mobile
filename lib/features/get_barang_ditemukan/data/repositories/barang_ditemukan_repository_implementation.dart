import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:benu_app/core/failure.dart';
import 'package:benu_app/features/get_barang_ditemukan/data/sources/network/network.dart';
import 'package:benu_app/features/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
import 'package:benu_app/features/get_barang_ditemukan/domain/repository/barang_ditemukan_repository.dart';
import 'package:dartz/dartz.dart';

class BarangDitemukanRepositoryImplementation
    extends BarangDitemukanRepository {
  final BarangDitemukanRemoteDatasource barangDitemukanRemoteDatasource;

  BarangDitemukanRepositoryImplementation(
      {required this.barangDitemukanRemoteDatasource});

  @override
  Future<Either<Failure, List<BarangDitemukanEntity>>>
      getBarangDitemukan() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await Connectivity().checkConnectivity();

      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        return const Left(Failure(
          errorMessage: 'errorMessage',
        ));
      } else {
        final List<BarangDitemukanEntity> result =
            await barangDitemukanRemoteDatasource.getBarangDitemukan();
        return Right(result);
      }
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}





























// import 'package:benu_app/features/get_barang_ditemukan/data/sources/network/network.dart';
// import 'package:benu_app/features/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
// import 'package:benu_app/features/get_barang_ditemukan/domain/repository/barang_ditemukan_repository.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../core/failure.dart';

// class BarangDitemukanRepositoryImpl implements BarangDitemukanRepository {
//   final Api _api;

//   BarangDitemukanRepositoryImpl({
//     required Api api,
//   }) : _api = api;

//   @override
//   Future<Either<Failure, List<BarangDitemukanEntity>>>
//       getBarangDitemukan() async {
//     final fetchedDataList = await _api.loadBarangDitemukan();
//     final barangDitemukanEntities = fetchedDataList
//         .map((dto) => BarangDitemukanEntity(
//               id: dto.id,
//               namaBarang: dto.namaBarang,
//               namaPenemu: dto.namaPenemu,
//               profilePicture: dto.profilePicture,
//               tanggalDitemukan: dto.tanggalDitemukan,
//               lokasiDitemukan: dto.lokasiDitemukan,
//               detail: dto.detail,
//               imagePath: dto.imagePath,
//               createdAt: dto.createdAt,
//             ))
//         .toList();
//     return Right(barangDitemukanEntities);
//   }
// }
