import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UX demo',
      home: MessageListScreen(),
    );
  }
}

class Message {
  final String msg;
  final int timestamp;

  Message(this.msg, this.timestamp);

  @override
  String toString() {
    return 'Message{msg: $msg, timestamp: $timestamp}';
  }

}

class MessageList extends StatefulWidget {

  MessageList({Key key}): super(key: key);

  @override
  State createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessageList> {
  final List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          final subtitle = DateTime.fromMillisecondsSinceEpoch(msg.timestamp)
              .toLocal().toIso8601String();
          return ListTile(
            title: Text(msg.msg),
            subtitle: Text(subtitle),
          );
        }
    );
  }

  void addMessage(Message msg) {
    setState(() {
      messages.add(msg);
    });
  }
}


class MessageListScreen extends StatelessWidget {

  //引入一个 GlobalKey 的原因在于，
  //MessageListScreen 需要把从 AddMessageScreen 返回的数据放到 _MessageListState 中，
  //而我们无法从 MessageList 拿到这个 state。
  final messageListKey = GlobalKey<_MessageListState>(debugLabel: 'messageListKey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Echo client'),
        ),
        body: MessageList(key: messageListKey),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // push 一个新的 route 到 Navigator 管理的栈中，以此来打开一个页面
            // Navigator.push 会返回一个 Future<T>，如果你对这里使用的 await
            // 不太熟悉，可以参考
            // https://www.dartlang.org/guides/language/language-tour#asynchrony-support
            final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddMessageScreen())
            );
            debugPrint('result = $result');
            if (result is Message) {
              //GlobalKey 是应用全局唯一的 key，把这个 key 设置给 MessageList 后，
              //我们就能够通过这个 key 拿到对应的 statefulWidget 的 state。
              messageListKey.currentState.addMessage(result);
            }
          },
          tooltip: 'Add message',
          child: Icon(Icons.add),
        )
    );
  }
}


class MessageForm extends StatefulWidget {

  @override
  State createState() {
    return _MessageFormState();
  }

}

class _MessageFormState extends State<MessageForm> {
  final editController = TextEditingController();

  // 对象被从 widget 树里永久移除的时候调用 dispose 方法（可以理解为对象要销毁了）
  // 这里我们需要主动再调用 editController.dispose() 以释放资源
  @override
  void dispose() {
    super.dispose();
    editController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 我们让输入框占满一行里除按钮外的所有空间
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Input message',
                  contentPadding: EdgeInsets.all(0.0),
                ),
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black54
                ),
                // 获取文本的关键，这里要设置一个 controller
                controller: editController,
                autofocus: true,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              debugPrint('send: ${editController.text}');
              final msg = Message(
                  editController.text,
                  DateTime.now().millisecondsSinceEpoch
              );
              Navigator.pop(context, msg);
            },
            onDoubleTap: () => debugPrint('double tapped'),
            onLongPress: () => debugPrint('long pressed'),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text('Send'),
            ),
          )
        ],
      ),
    );
  }
}


class AddMessageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add message'),
      ),
      body: MessageForm(),
    );
  }
}
