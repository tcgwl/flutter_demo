import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class FutureButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FutureState();
  }
}

class _FutureState extends State<FutureButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _onStream,
      child: Text('Future练习'),
    );
  }

  void _onFuture() {
//    Future.delayed(Duration(seconds: 2), (){
//      //return "hi world!";
//      throw AssertionError("Error");
//    }).then((data){
//      //执行成功会走到这里
//      print("success: $data");
//    }).catchError((e){
//      //执行失败会走到这里
//      print("error: $e");
//    }).whenComplete((){
//      //无论成功或失败都会走到这里
//    });

//    //并不是只有 catchError回调才能捕获错误，then方法还有一个可选参数onError，我们也可以它来捕获异常
//    Future.delayed(Duration(seconds: 2), (){
//      throw AssertionError("Error");
//    }).then((data){
//      print("success: $data");
//    }, onError: (e){
//      print("error: $e");
//    });

    Future.wait([
      // 2秒后返回结果
      Future.delayed(Duration(seconds: 2), (){
        return "Hello";
      }),
      // 4秒后返回结果
      Future.delayed(Duration(seconds: 4), (){
        return "World";
      })
    ]).then((results){
      print("success: ${results[0]}, ${results[1]}");
    }).catchError((e){
      print("error: $e");
    });
  }

  ///Stream 也是用于接收异步事件数据，和Future 不同的是，它可以接收多个异步操作的结果（成功或失败）。
  ///也就是说，在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。
  ///Stream 常用于会多次读取数据的异步任务场景，如网络内容下载、文件读写等。
  void _onStream() {
    Stream.fromFutures([
      // 1秒后返回结果
      Future.delayed(Duration(seconds: 1), (){
        return "hi 1";
      }),
      Future.delayed(Duration(seconds: 2), (){
        throw AssertionError("Error");
      }),
      Future.delayed(Duration(seconds: 3), (){
        return "hello 3";
      })
    ]).listen((data){
      print(data);
    }, onError: (e){
      print(e.message);
    }, onDone: (){
      print("done");
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Future Demo',
      //应用的'主页'
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Future Demo'),
        ),
        //屏幕中间放置一按钮
        body: Center(
          child: FutureButton(),
        ),
      ),
    );
  }

}