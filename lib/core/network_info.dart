import 'package:data_connection_checker_tv/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool>? get isConnected;
}

class NetworkInfoImplement implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImplement(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
