import 'package:cartao_ponto/ui/home_page.dart';
import 'package:flutter/material.dart';

import 'fragments/frag_login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Cartão de Ponto',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Login(),
    );
  }
}