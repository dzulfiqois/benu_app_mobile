// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/entity/barang_entity.dart';

class BarangDitemukanEntity extends BarangEntity {
  @override
  final String id;
  @override
  final String namaBarang;
  @override
  final String detail;
  @override
  final String imagePath;
  @override
  final String createdAt;

  final String namaPenemu;
  final String profilePicture;
  final String tanggalDitemukan;
  final String lokasiDitemukan;

  BarangDitemukanEntity({
    required this.id,
    required this.namaBarang,
    required this.namaPenemu,
    required this.profilePicture,
    required this.tanggalDitemukan,
    required this.lokasiDitemukan,
    required this.detail,
    required this.imagePath,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        namaBarang,
        namaPenemu,
        profilePicture,
        tanggalDitemukan,
        lokasiDitemukan,
        detail,
        imagePath,
        createdAt,
      ];
}
