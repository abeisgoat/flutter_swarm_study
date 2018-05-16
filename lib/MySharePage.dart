import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySharePage extends StatefulWidget {
  MySharePage({Key key}) : super(key: key);

  @override
  _MySharePageState createState() => new _MySharePageState();
}

class _MySharePageState extends State<MySharePage> {
  static const platform = const MethodChannel('app.channel.shared.data');
  String dataShared = "{}";

  @override
  void initState() {
    super.initState();
    getSharedText();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Text(dataShared),
          new RaisedButton(onPressed: _buttonPressed, child: new Text("Fetch"),)
        ],)
    ));
  }

  void _buttonPressed() {
    getSharedText();
  }

  getSharedText() async {
    var sharedData = await platform.invokeMethod("getSharedText");

    setState(() {
      dataShared = sharedData ?? "{}";
    });
  }
}