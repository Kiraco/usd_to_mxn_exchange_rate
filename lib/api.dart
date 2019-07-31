import 'package:http/http.dart' as http;

// Performs the fetch of rates from go server
class API {
  static Future GetProvidersData() {
    var url = "http://localhost:3000/rates";
    var headers = {"Content-Type": "application/json"};
    return http.get(url, headers: headers);
  }

  static Future UpdateProvidersData() {
    var url = "http://localhost:3000/update";
    return http.get(url);
  }
}
