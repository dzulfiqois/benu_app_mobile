import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/data/sources/network/network.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/provider/barang_ditemukan_provider.dart';
import 'package:benu_app/features/barang_ditemukan/get_barang_ditemukan/presentation/provider/post_barang_ditemukan_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/barang_ditemukan/get_barang_ditemukan/data/repositories/barang_ditemukan_repository_implementation.dart';
import 'features/barang_ditemukan/get_barang_ditemukan/domain/usecase/post_barang_ditemukan.dart';
import 'features/barang_ditemukan/get_barang_ditemukan/presentation/pages/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BarangDitemukanProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PostBarangDitemukanProvider(
            PostBarangDitemukan(BarangDitemukanRepositoryImplementation(
                barangDitemukanRemoteDatasource:
                    BarangDitemukanRemoteDatasourceImpl(dio: Dio()))),
          ),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Benu App',
        showPerformanceOverlay: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen());
  }
}
