import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '文件存储和网络',
      //应用的'主页'
      home: Scaffold(
        appBar: AppBar(
          title: Text('文件存储和网络'),
        ),
        //屏幕中间放置一按钮
        body: Center(
          child: Object2JsonButton(),
        ),
      ),
    );
  }

}

class Point {
  int x;
  int y;
  String description;

  Point(this.x, this.y, this.description);

  // 为了把对象转换为 JSON，我们给他定义一个 toJson 方法（注意，不能改变他的方法签名）

  // 之所以限定 toJson 方法的原型，是因为 json.encode 只支持 Map、List、String、int 等内置类型。
  // 当它遇到不认识的类型时，如果没有给它设置参数 toEncodable，就会调用对象的 toJson 方法（所以方法的原型不能改变）

  // 注意，我们的方法只有一个语句，这个语句定义了一个 map。
  // 使用这种语法的时候，Dart 会自动把这个 map 当做方法的返回值
  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y,
    'desc': description
  };

  //把 JSON 转换为对象
  Point.fromJson(Map<String, dynamic> map)
    : x = map['x'], y = map['y'], description = map['desc'];

  @override
  String toString() {
    return "Point{x=$x, y=$y, desc=$description}";
  }
}

class Object2JsonButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Object2JsonState();
}

class _Object2JsonState extends State<Object2JsonButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onObject2Json,
      child: Text('对象和JSON的互换'),
    );
  }

  void _onObject2Json() {
    var point = Point(2, 12, 'Some point');
    // 调用 json.encode 方法把对象转换为 JSON
    var pointJson = json.encode(point);
    print('pointJson = $pointJson');
    // List, Map 都是支持的
    var points = [point, point];
    var pointsJson = json.encode(points);
    print('pointsJson = $pointsJson');
    print('');

    // 调用 json.decode 方法把JSON转换为 对象
    var decoded = json.decode(pointJson);
    print('decoded.runtimeType = ${decoded.runtimeType}');
    var point2 = Point.fromJson(decoded);
    print('point2 = $point2');

    decoded = json.decode(pointsJson);
    print('decoded.runtimeType = ${decoded.runtimeType}');
    var points2 = <Point>[];
    for (var map in decoded) {
      points2.add(Point.fromJson(map));
    }
    print('points2 = $points2');
  }
}
