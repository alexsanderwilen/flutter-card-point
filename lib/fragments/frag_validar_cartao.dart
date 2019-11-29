import 'dart:convert';
import 'dart:core' as prefix0;
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/foundation.dart';


class ValidarCartao extends StatefulWidget {
  @override
  _ValidarCartaoState createState() => _ValidarCartaoState();
}

class _ValidarCartaoState extends State<ValidarCartao> {
  String photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: photo != null ?
                      FileImage(File(photo)) :
                      AssetImage('assets/ponto.png'),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              onTap: () {
                ImagePicker.pickImage(source: ImageSource.camera).then((file) {
                  if (file == null) return;
                  setState(() {
                    photo = file.path;
                    print(photo);
                  });
                });
              },
            ),
            Divider(
              height: 100,
            ),

            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("TIRAR FOTO"),
                  onPressed: () {
                    ImagePicker.pickImage(source: ImageSource.camera,
                        maxHeight: 600,
                        maxWidth: 600).then((file) {
                      if (file == null) return;
                      setState(() {
                        photo = file.path;
                        print(photo);
                      });
                    });
                  },
                ),
              )
            ]
            ),

            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("VER GALERIA"),
                  onPressed: () {
                    ImagePicker.pickImage(source: ImageSource.gallery).then((
                        file) {
                      if (file == null) return;
                      setState(() {
                        photo = file.path;
                        print(photo);
                      });
                    });
                  },
                ),
              )
            ]
            ),

            Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text("VALIDAR CARTÃO"),
                  onPressed: () async {
                    await uploadFiles();
                  },
                ),
              )
            ]
            ),
          ],
        ),
      ),
    );
  }

  Future<String> validaDadosImagem() async {
    String url = "http://SancodePonto-env.ngqrp5khcv.us-east-2.elasticbeanstalk.com:8080/pontos/valida";


    String sj = '{"email": "alexsanderwilen@sancode.com.br", "senha": "123"}';
    var response = await http.post(url, body: sj);
    return response.headers["authorization"];
  }

  Future<String> Upload() async {
//    String url = "http://SancodePonto-env.ngqrp5khcv.us-east-2.elasticbeanstalk.com:8080/pontos/valida";
    var uri = Uri.parse(
        "http://SancodePonto-env.ngqrp5khcv.us-east-2.elasticbeanstalk.com:8080/pontos/valida");

    File imageFile = File(photo);
    var request = new http.MultipartRequest("POST", uri);
    //var multipartFile = await http.MultipartFile.fromPath("files", imageFile.path, contentType: 'application/form-data'));
    // var response = await http.post(uri, body: multipartFile);

//    request.files.add(new http.MultipartFile.fromPath(
//        'files',
//        contentType: new MediaType('application', 'form-data'));
    //   print(response.body);
    return "";
  }

  Future uploadFiles() async {
    File imageFile = File(photo);
    final url = Uri.parse(
        "http://SancodePonto-env.ngqrp5khcv.us-east-2.elasticbeanstalk.com:8080/pontos/valida");
    final fileName = basename(imageFile.path);
    //final bytes = imageFile.readAsBytesSync();
    final bytes = imageFile.readAsBytesSync();

    var request = http.MultipartRequest('POST', url)
      ..files.add(
        new http.MultipartFile.fromBytes(
          'files',
          bytes,
          filename: fileName,
        ),
      );

    var response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);
    print(decoded);
  }

//  List<int> compress(List<int> bytes) {
//    var image = img.decodeImage(bytes);
//    var resize = img.copyResize(image, 480);
//    return img.encodePng(resize, level: 1);
//  }

}