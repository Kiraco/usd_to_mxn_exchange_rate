import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:usd_to_mxn_exchange_rate/exchange_rate_page.dart';
import 'package:usd_to_mxn_exchange_rate/api.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

enum FormMode { LOGIN, SIGNUP }

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 600,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_showBody()],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    window.history.pushState("", "home", "/");
    super.initState();
  }

  Widget _showCheckRatesButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: MaterialButton(
            elevation: 5.0,
            minWidth: 200.0,
            height: 42.0,
            color: Color.fromRGBO(0, 207, 119, 1),
            child: Text('Check rates',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExchangeRates()),
              );
            } //_validateAndSubmit,
            ));
  }

  Widget _showUpdateButton() {
    return FlatButton(
        child: Text('Update rates...',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: () {
          API.UpdateProvidersData();
        });
  }

  Widget _showBody() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showCheckRatesButton(),
              _showUpdateButton(),
            ],
          ),
        ));
  }
}
