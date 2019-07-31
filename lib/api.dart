import 'package:http/http.dart' as http;
import 'package:usd_to_mxn_exchange_rate/data/local_storage.dart';

// Performs the fetch of rates from go server
class API {
  static Future GetProvidersData() {
    var url = "http://localhost:3000/rates";
    var headers = {"Content-Type": "application/json"};
    return http.get(url, headers: headers);
  }

  static Future UpdateProvidersData() {
    LocalStorage().Invalidate("Banxico");
    LocalStorage().Invalidate("Fixer");
    LocalStorage().Invalidate("Diario Oficial de la Federacion");
    var url = "http://localhost:3000/update";
    return http.get(url);
  }
}
