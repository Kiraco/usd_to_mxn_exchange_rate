import 'dart:html' as prefix0;

import 'package:flutter_web/material.dart';
import 'package:usd_to_mxn_exchange_rate/models/provider_model.dart';
import 'package:usd_to_mxn_exchange_rate/providers/banxico.dart';
import 'package:usd_to_mxn_exchange_rate/providers/diario_oficial_federacion.dart';
import 'package:usd_to_mxn_exchange_rate/providers/fixer.dart';
import 'package:usd_to_mxn_exchange_rate/providers/provider.dart';

final providers = [Banxico(), Fixer(), DiarioOficialFederacion()];

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
    return ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: providers.length,
        itemBuilder: /*1*/ (context, i) {
          final provider = providers[i];
          return _buildRow(provider);
        });
  }
  // #enddocregion _buildExchangeRates

  // #docregion _buildRow
  Widget _buildRow(Provider provider) {
    ProviderModel providerModel = provider.getProviderModel();
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(1, 5, 1, 5),
      title: Text(providerModel.getProvider(), style: _biggerFont),
      subtitle: Text(
          "Rate: " +
              providerModel.getValue() +
              "\nLast update: " +
              providerModel.getUpdatedAt(),
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
  // #enddocregion RWS-build
  // #docregion RWS-var
}
// #enddocregion RWS-var

class ExchangeRates extends StatefulWidget {
  @override
  ExchangeRatesState createState() => ExchangeRatesState();
}
