import 'package:flutter_web/material.dart';
//import 'package:usd_to_mxn_exchange_rate/exchangeRatePage.dart';
import 'package:usd_to_mxn_exchange_rate/login_signup_page.dart';
//import 'loginPage.dart';
//import 'exchangeRatePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'USD to MXN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpPage(),
    );
  }
}
