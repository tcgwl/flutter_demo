import 'package:flutter/material.dart';

class DemoItem extends StatefulWidget {
  @override
  _DemoItemState createState() => _DemoItemState();
}

class _DemoItemState extends State<DemoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      ///卡片包装
      child: Card(
        child: FlatButton(
          onPressed: (){print('点击了哦');},
          child: Padding(
            padding: EdgeInsets.only(left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ///文本描述
                Container(
                  child: Text(
                    '这是一点描述',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54
                    ),
                    ///最长三行，超过 ... 显示
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                  alignment: Alignment.topLeft,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                ///三个平均分配的横向图标文字
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getBottomItem(Icons.star, "1000"),
                    _getBottomItem(Icons.link, "1000"),
                    _getBottomItem(Icons.subject, "1000"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///返回一个居中带图标和文本的Item
  _getBottomItem(IconData icon, String text) {
    ///充满 Row 横向的布局
    return Expanded(
      flex: 1,
      child: Center(
        child: Row(
          ///主轴居中,即是横向居中
          mainAxisAlignment: MainAxisAlignment.center,
          ///大小按照最大充满
          mainAxisSize: MainAxisSize.max,
          ///竖向也居中
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 16.0,
              color: Colors.grey,
            ),
            Padding(padding: EdgeInsets.only(left: 5.0)),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
              //最长一行
              maxLines: 1,
              //超过的省略为...显示
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
