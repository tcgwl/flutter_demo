import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleSection = _TitleSection('Oeschinen Lake Campground', 'Kandersteg, Switzerland', 64);
    final buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(context, Icons.call, 'CALL'),
          _buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );
    final textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        '''
    Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter UI basic 1',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Top Lakes'),
        ),
        // 由于我们的内容可能会超出屏幕的长度，这里把内容都放到 ListView 里。
        // 除了这种用法，ListView 也可以像我们在 Android 原生开发中使用 ListView 那样，
        // 根据数据动态生成一个个 item
        body: ListView(
          children: <Widget>[
            Image.asset(
              'images/lake.jpg',
              width: 600.0,
              height: 240.0,
              // cover 类似于 Android 开发中的 centerCrop，其他一些类型，读者可以查看
              // https://docs.flutter.io/flutter/painting/BoxFit-class.html
              fit: BoxFit.cover,
            ),

            titleSection,
            buttonSection,
            textSection
          ],
        ),
      ),
    );
  }

}

class _TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final int starCount;

  _TitleSection(this.title, this.subtitle, this.starCount);

  @override
  Widget build(BuildContext context) {
    // 为了给 title section 加上 padding，这里给内容套一个 Container
    return Container(
      // 设置上下左右的 padding 都是 32px。类似的还有 EdgeInsets.only/symmetric 等
      padding: EdgeInsets.all(32.0),
      // 只有一个子元素的 widget，一般使用 child 参数来设置
      // 像下面使用的 Row，包含有多个元素，对应的则是 children。
      // Row、Column 类似于 Android 开发里面使用的 LinearLayout，分别对应 orientation 为 horizontal 和 vertical。
      child: Row(
        children: <Widget>[
          // 和 LinearLayout 一样，我们从左到右放入子元素。
          // Expanded 提供了 LinearLayout layout_weight 类似的功能。
          // 这里为了让标题占满屏幕宽度的剩余空间，用 Expanded 把标题包了起来
          Expanded(
            // Expanded 只能包含一个子元素，使用的参数名是 child。接下来，
            // 为了在竖直方向放两个标题，加入一个 Column。
              child: Column(
                // Column 是竖直方向的，cross 为交叉的意思，也就是说，这里设置的是水平方向
                // 的对齐。在水平方向，我们让文本对齐到 start
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              )
          ),
          // 这里是 Row 的第二个子元素
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),

          Container(
              margin: const EdgeInsets.only(left: 5.0),
              child: Text(starCount.toString())
          )

        ],
      ),
    );
  }

}

Widget _buildButtonColumn(BuildContext context, IconData icon, String label) {
  final color = Theme.of(context).primaryColor;

  return Column(
    // main axis 跟 cross axis 相对应，对 Column 来说，指的就是竖直方向。
    // 在放置完子控件后，屏幕上可能还会有一些剩余的空间（free space），
    // min 表示尽量少占用 free space；类似于 Android 的 wrap_content。
    // 对应的，还有 MainAxisSize.max
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(icon, color: color),
      Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color
          ),
        ),
      )
    ],
  );
}
