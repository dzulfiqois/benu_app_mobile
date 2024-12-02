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


////////////////////////////////////////////
////  Contoh data
////////////////////////////////////////////

// {
//         "createdAt": "2024-11-24T15:53:53.017Z",
//         "nama_barang": "Licensed Granite Chips",
//         "nama_penemu": "Joanna Greenfelder",
//         "profile_picture": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1096.jpg",
//         "tanggal_ditemukan": "2024-11-24T14:53:46.140Z",
//         "lokasi_ditemukan": "East Jerrold",
//         "detail": "Asperiores voluptate architecto dolor labore inventore distinctio.\nEius illo similique dolores quas.\nQuisquam deleniti laudantium consequuntur autem odio.",
//         "image_path": "https://loremflickr.com/640/480",
//         "id": "1"
//     },



// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';

// class BarangEntity extends Equatable {
//   final String id;
//   final String namaBarang;
//   final String namaPenemu;
//   final String profilePicture;
//   final String tanggalDitemukan;
//   final String lokasiDitemukan;
//   final String detail;
//   final String imagePath;
//   final String createdAt;

//   const BarangEntity({
//     required this.id,
//     required this.namaBarang,
//     required this.namaPenemu,
//     required this.profilePicture,
//     required this.tanggalDitemukan,
//     required this.lokasiDitemukan,
//     required this.detail,
//     required this.imagePath,
//     required this.createdAt,
//   });

//   @override
//   List<Object> get props => [
//         id,
//         namaBarang,
//         namaPenemu,
//         profilePicture,
//         tanggalDitemukan,
//         lokasiDitemukan,
//         detail,
//         imagePath,
//         createdAt,
//       ];
// }


// ////////////////////////////////////////////
// ////  Contoh data
// ////////////////////////////////////////////

// // {
// //         "createdAt": "2024-11-24T15:53:53.017Z",
// //         "nama_barang": "Licensed Granite Chips",
// //         "nama_penemu": "Joanna Greenfelder",
// //         "profile_picture": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1096.jpg",
// //         "tanggal_ditemukan": "2024-11-24T14:53:46.140Z",
// //         "lokasi_ditemukan": "East Jerrold",
// //         "detail": "Asperiores voluptate architecto dolor labore inventore distinctio.\nEius illo similique dolores quas.\nQuisquam deleniti laudantium consequuntur autem odio.",
// //         "image_path": "https://loremflickr.com/640/480",
// //         "id": "1"
// //     },
