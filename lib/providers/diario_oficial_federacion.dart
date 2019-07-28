import 'package:flutter_web/io.dart';
import 'package:usd_to_mxn_exchange_rate/models/provider_model.dart';
import 'package:usd_to_mxn_exchange_rate/providers/provider.dart';
import 'package:http/http.dart' as http;

String Body = "";

class DiarioOficialFederacion implements Provider {
  ProviderModel getProviderModel() {
    ProviderModel dummyProviderModel = ProviderModel();
    dummyProviderModel.setProvider("Diario Oficial de la Federacion");
    dummyProviderModel.setUpdatedAt(DateTime.now().toIso8601String());
    dummyProviderModel.setValue("15.12");
    String baseUrl = 'http://www.banxico.org.mx/tipcamb/tipCamIHAction.do';

    String date = "26" +
        '/0' +
        DateTime.now().month.toString() +
        '/' +
        DateTime.now().year.toString();
    var body = {
      'idioma': 'sp',
      'fechaInicial': date,
      'fechaFinal': date,
      'salida': 'HTML'
    };
    var headers = {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Future future = http.post(baseUrl, body: body, headers: headers);
    future.then((resp) {
      doSomehting(resp as http.Response);
    });
    return dummyProviderModel;
  }

  void doSomehting(http.Response response) {
    print(response.body);
    Body = response.body;
  }
}
