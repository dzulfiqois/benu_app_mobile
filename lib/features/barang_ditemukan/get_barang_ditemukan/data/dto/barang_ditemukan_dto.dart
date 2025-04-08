import 'dart:convert';

import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/domain/entity/barang_ditemukan_entity.dart';

class BarangDitemukanDto extends BarangDitemukanEntity {
  BarangDitemukanDto({
    required super.id,
    required super.namaBarang,
    required super.namaPenemu,
    required super.profilePicture,
    required super.tanggalDitemukan,
    required super.lokasiDitemukan,
    required super.detail,
    required super.imagePath,
    required super.createdAt,
  });

  //////////////////////////
  //// JSON
  //////////////////////////

  factory BarangDitemukanDto.fromRawJson(String str) =>
      BarangDitemukanDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  //////////////////////////
  /// MAPS
  //////////////////////////

  factory BarangDitemukanDto.fromMap(Map<String, dynamic> json) =>
      BarangDitemukanDto(
        id: json['id'] ?? '',
        namaBarang:
            json['nama_barang'] ?? '', // Default to empty string if null
        namaPenemu: json['nama_penemu'] ?? '',
        profilePicture: json['profile_picture'] ?? '',
        tanggalDitemukan: json['tanggal_ditemukan'] ?? '',
        lokasiDitemukan: json['lokasi_ditemukan'] ?? '',
        detail: json['detail'] ?? '',
        imagePath: json['image_path'] ?? '',
        createdAt: json['created_at'] ?? '',
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_barang': namaBarang,
        'nama_penemu': namaPenemu,
        'profile_picture': profilePicture,
        'tanggal_ditemukan': tanggalDitemukan,
        'lokasi_ditemukan': lokasiDitemukan,
        'detail': detail,
        'image_path': imagePath,
        'created_at': createdAt,
      };

  //////////////////////////
  /// ENTITY CONVERSION
  //////////////////////////

  factory BarangDitemukanDto.fromEntity(
          BarangDitemukanEntity barangDitemukan) =>
      BarangDitemukanDto(
        id: barangDitemukan.id,
        namaBarang: barangDitemukan.namaBarang,
        namaPenemu: barangDitemukan.namaPenemu,
        profilePicture: barangDitemukan.profilePicture,
        tanggalDitemukan: barangDitemukan.tanggalDitemukan,
        lokasiDitemukan: barangDitemukan.lokasiDitemukan,
        detail: barangDitemukan.detail,
        imagePath: barangDitemukan.imagePath,
        createdAt: barangDitemukan.createdAt,
      );

  BarangDitemukanEntity toEntity() {
    return BarangDitemukanEntity(
      id: id,
      namaBarang: namaBarang,
      namaPenemu: namaPenemu,
      profilePicture: profilePicture,
      tanggalDitemukan: tanggalDitemukan,
      lokasiDitemukan: lokasiDitemukan,
      detail: detail,
      imagePath: imagePath,
      createdAt: createdAt,
    );
  }
}
