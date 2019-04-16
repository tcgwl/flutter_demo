import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class RollingButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RollingState();
  }

}

class _RollingState extends State<RollingButton> {
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onPressed,
      child: Text('Roll'),
    );
  }


  void _onPressed() {
    debugPrint('_RollingState._onPressed()');

    final rollResults = _roll();
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text('Roll result: (${rollResults[0]}, ${rollResults[1]})'),
          );
        }
    );
  }

  List<int> _roll() {
    final roll1 = _random.nextInt(6) + 1;
    final roll2 = _random.nextInt(6) + 1;
    return [roll1, roll2];
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //移动设备使用这个title来表示该应用
      title: 'First Flutter App',
      //应用的'主页'
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Rolling Demo'),
        ),
        //屏幕中间放置一按钮
        body: Center(
          child: RollingButton(),
        ),
      ),
    );
  }

}