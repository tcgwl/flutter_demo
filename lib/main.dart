import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation',
      home: Scaffold(
        appBar: AppBar(
          title: Text('animation'),
        ),
        body: AnimWidget(),
      ),
    );
  }
}

// 动画是有状态的
class AnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimWidgetState();
  }
}

class _AnimWidgetState extends State<AnimWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    //AnimationController 的输出是线性的
    controller = AnimationController(
      // 动画的时长
        duration: Duration(milliseconds: 5000),
        // 提供 vsync 最简单的方式，就是直接继承 SingleTickerProviderStateMixin
        vsync: this
    );

    curve = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut
    );

    // 调用 forward 方法开始动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
//    return ScaleTransition(
//      child: FlutterLogo(size: 200.0),
//      //线性动画
//      //scale: controller,
//      //非线性动画
//      scale: curve,
//    );

    //组合动画
    var scaled = ScaleTransition(
      child: FlutterLogo(size: 200.0),
      scale: curve,
    );

    return FadeTransition(
      child: scaled,
      opacity: curve,
    );
  }
}