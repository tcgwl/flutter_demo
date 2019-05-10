import 'package:flutter/material.dart';
import 'package:flutter_demo/cardList/DemoItem.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///背景样式
      backgroundColor: Colors.blue,
      ///标题栏
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return DemoItem();
        },
        itemCount: 20,
      ),
    );
  }
}
