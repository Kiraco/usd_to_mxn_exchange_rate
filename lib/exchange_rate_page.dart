import 'package:flutter_web/material.dart';
import 'package:usd_to_mxn_exchange_rate/models/provider_model.dart';

// #docregion RWS-var
class ExchangeRatesState extends State<ExchangeRates> {
  final _biggerFont = const TextStyle(
      fontSize: 20.0,
      color: Color.fromRGBO(0, 207, 119, 1),
      fontWeight: FontWeight.bold,
      letterSpacing: 1);
  final _smallerFont =
      const TextStyle(fontSize: 14.0, wordSpacing: 2, letterSpacing: .5);
  // #enddocregion RWS-var

  // #docregion _buildExchangeRates
  Widget _buildExchangeRates() {
    var providersData = getProvidersData();
    return ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: providersData.length,
        itemBuilder: /*1*/ (context, i) {
          final provider = providersData[i];
          return _buildRow(provider);
        });
  }
  // #enddocregion _buildExchangeRates

  // #docregion _buildRow
  Widget _buildRow(ProviderModel provider) {
    // Get data from DB provider.getProviderModel();
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(1, 5, 1, 5),
      title: Text(provider.getProvider(), style: _biggerFont),
      subtitle: Text(
          "Rate: " +
              provider.getRate() +
              "\nLast update: " +
              provider.getUpdatedAt(),
          style: _smallerFont),
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USD to MXN rate'),
        backgroundColor: Color.fromRGBO(0, 207, 119, 1),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 600,
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Center(child: _buildExchangeRates())),
        ),
      ),
    );
  }

  getProvidersData() async {
    List providerModels;
    var connection = PostgreSQLConnection(host, port, dbName,
        username: user, password: pass);
    /*await connection.open();
    for (final priv in providers) {
     
      List<List<dynamic>> results =
          await connection.query(query, substitutionValues: {"table": priv});
      ProviderModel providerModel = ProviderModel();
      for (final row in results) {
        print(row);
        providerModel.setProvider("provider");
        providerModel.setRate("rate");
        providerModel.setUpdatedAt("udpated");
      }
      providerModels.add(providerModel);
    }*/
    return providerModels;
  }
  // #enddocregion RWS-build
  // #docregion RWS-var
}
// #enddocregion RWS-var

class ExchangeRates extends StatefulWidget {
  @override
  ExchangeRatesState createState() => ExchangeRatesState();
}
