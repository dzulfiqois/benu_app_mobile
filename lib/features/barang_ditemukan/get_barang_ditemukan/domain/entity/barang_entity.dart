// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class BarangEntity extends Equatable {
  String get id;
  String get namaBarang;
  String get detail;
  String get imagePath;
  String get createdAt;

  @override
  List<Object?> get props => [
        id,
        namaBarang,
        detail,
        imagePath,
        createdAt,
      ];
}
