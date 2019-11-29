import 'package:flutter/material.dart';

class SalvarDadosCartao extends StatefulWidget {

  final String jsonStr;

  SalvarDadosCartao({Key key, @required this.jsonStr}) : super(key: key);

  @override
  _SalvarDadosCartaoState createState() =>
      _SalvarDadosCartaoState(jsonStr: this.jsonStr);
}

class _SalvarDadosCartaoState extends State<SalvarDadosCartao> {

  String jsonStr;

  _SalvarDadosCartaoState({Key key, this.jsonStr});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(jsonStr)
          ],
        ),
      ),
    );
  }
}



