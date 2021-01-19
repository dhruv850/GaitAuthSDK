import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('demo.gawkat.com/info'); //method channel

  String _message = "Click to show secret";
  @override
  void initState() {
    // fetch and change the message from the platform
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text(_message),
          ),
          RaisedButton(onPressed: buttonFunction, child:Text('Secret'),
          ),
        ],
      ),
    );
  }

  buttonFunction() {
    _getMessage().then((String message) {
      setState(() {
        _message = message;
      });
    });
  }


  Future<String> _getMessage() async {          //sending and retrieving the message
    var sendMap = <String, dynamic> {
      'from' : 'Flutter',
    };
    String value;
    try {
      value = await platform.invokeMethod('getMessage', sendMap);
      print(value);
    } catch (e) {
      print(e);
    }
    return value;
  }
}