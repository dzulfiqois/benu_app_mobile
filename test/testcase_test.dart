// import 'package:benu_app/core/failure.dart';
// import 'package:benu_app/features/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';
// import 'package:benu_app/features/get_barang_ditemukan/domain/repository/barang_ditemukan_repository.dart';
// import 'package:benu_app/features/get_barang_ditemukan/domain/usecase/get_barang_ditemukan.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// // Generate mock class for BarangDitemukanRepository
// @GenerateMocks([BarangDitemukanRepository])
// // import 'get_barang_ditemukan_test.mocks.dart';
// import 'testcase_test.mocks.dart';

// void main() {
//   // Define the use case and mock repository
//   late GetBarangDitemukan usecase;
//   late MockBarangDitemukanRepository mockRepository;

//   // Test setup
//   setUp(() {
//     mockRepository = MockBarangDitemukanRepository();
//     usecase = GetBarangDitemukan(mockRepository);
//   });

//   // Test data
//   final testBarangDitemukanEntity = BarangDitemukanEntity(
//     id: 1,
//     namaBarang: 'Laptop',
//     namaPenemu: 'John Doe',
//     profilePicture: 'profile.jpg',
//     tanggalDitemukan: '2024-11-01',
//     lokasiDitemukan: 'Library',
//     detail: 'Dell XPS 13',
//     imagePath: 'laptop.jpg',
//     createdAt: '2024-10-25',
//   );

//   const testFailure = Failure(message: 'ERROR', errorMessage: 'error');

//   // Group test cases
//   group('GetBarangDitemukan Usecase Tests', () {
//     test('should return BarangDitemukanEntity on successful repository call',
//         () async {
//       // Arrange
//       when(mockRepository.getBarangDitemukan())
//           .thenAnswer((_) async => Right(testBarangDitemukanEntity));

//       // Act
//       final result = await usecase();

//       // Assert
//       expect(result, equals(Right(testBarangDitemukanEntity)));
//       verify(mockRepository.getBarangDitemukan()).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     });

//     test('should return Failure on unsuccessful repository call', () async {
//       // Arrange
//       when(mockRepository.getBarangDitemukan())
//           .thenAnswer((_) async => const Left(testFailure));

//       // Act
//       final result = await usecase();

//       // Assert
//       expect(result, equals(const Left(testFailure)));
//       verify(mockRepository.getBarangDitemukan()).called(1);
//       verifyNoMoreInteractions(mockRepository);
//     });
//   });
// }
