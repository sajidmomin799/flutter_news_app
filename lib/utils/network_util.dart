
import 'package:connectivity_plus/connectivity_plus.dart';


class NetworkUtil{

  static NetworkUtil? _instance;

  NetworkUtil._();

  factory NetworkUtil() {
    if (_instance == null) {
      _instance = new NetworkUtil._();
    }
    return _instance!;
  }

  Future<bool> hasConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

}


