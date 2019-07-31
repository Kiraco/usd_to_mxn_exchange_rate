import 'dart:convert';
import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:usd_to_mxn_exchange_rate/data/local_storage.dart';
import 'package:usd_to_mxn_exchange_rate/home_page.dart';
import 'package:usd_to_mxn_exchange_rate/models/provider_model.dart';
import 'package:usd_to_mxn_exchange_rate/api.dart';

class ExchangeRatesState extends State<ExchangeRates> {
  final _biggerFont = const TextStyle(
      fontSize: 20.0,
      color: Color.fromRGBO(0, 207, 119, 1),
      fontWeight: FontWeight.bold,
      letterSpacing: 1);
  final _smallerFont =
      const TextStyle(fontSize: 14.0, wordSpacing: 2, letterSpacing: .5);

  // we get the providers, is a Future and resolved during the initState() of the view
  var providers = List<ProviderModel>();
  _getProviders() {
    API.GetProvidersData().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        providers = list.map((model) => ProviderModel.fromJson(model)).toList();
        for (ProviderModel provider in providers) {
          LocalStorage().Save(provider.getName(), provider.toString());
        }
      });
    });
    return providers;
  }

  _getFromCache() async {
    String banxicoData = await LocalStorage().GetData("Banxico");
    String fixerData = await LocalStorage().GetData("Fixer");
    String diarioData =
        await LocalStorage().GetData("Diario Oficial de la Federacion");
    if (banxicoData == null || fixerData == null || diarioData == null) {
      _getProviders();
    } else {
      providers.add(ProviderModel.fromJson(json.decode(banxicoData)));
      providers.add(ProviderModel.fromJson(json.decode(fixerData)));
      providers.add(ProviderModel.fromJson(json.decode(diarioData)));
    }
    return providers;
  }

  initState() {
    window.history.pushState("", "rates", "/rates");
    super.initState();
    _getFromCache();
  }

  dispose() {
    super.dispose();
  }

  Widget _buildExchangeRates(BuildContext context, AsyncSnapshot snapshot) {
    List<ProviderModel> values = snapshot.data;
    return ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: values.length,
        itemBuilder: /*1*/ (context, i) {
          final provider = values[i];
          if (i < 3) {
            return _buildRow(provider);
          }
        });
  }

  Widget _buildRow(ProviderModel provider) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(1, 5, 1, 5),
      title: Text(provider.getName(), style: _biggerFont),
      subtitle: Text(
          "Rate: " +
              provider.getRate() +
              "\nLast update: " +
              provider.getUpdatedAt(),
          style: _smallerFont),
    );
  }

  Widget _showGoBack() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: MaterialButton(
            elevation: 5.0,
            minWidth: 200.0,
            height: 42.0,
            color: Color.fromRGBO(0, 207, 119, 1),
            child: Text('Go Back',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } //_validateAndSubmit,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USD to MXN rate'),
        backgroundColor: Color.fromRGBO(0, 207, 119, 1),
        centerTitle: true,
      ),
      body: Center(
        //Wrap out body with a `WillPopScope` widget that handles when a user is cosing current route
        child: FutureBuilder(
            future: _getFromCache(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return _buildExchangeRates(context, snapshot);
            }),
      ),
    );
  }
}

class ExchangeRates extends StatefulWidget {
  @override
  ExchangeRatesState createState() => ExchangeRatesState();
}
