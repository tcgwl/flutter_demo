class Message {
  static const tableName = 'History';
  static const columnId = 'id';
  static const columnMsg = 'msg';
  static const columnTimestamp = 'timestamp';

  final String msg;
  final int timestamp;
  
  Message(this.msg, this.timestamp);

  Message.create(String msg)
      : msg = msg, timestamp = DateTime.now().millisecondsSinceEpoch;

  Message.fromJson(Map<String, dynamic> json)
      : msg = json['msg'], timestamp = json['timestamp'];

  Map<String, dynamic> toJson() => {
    "msg": "$msg",
    "timestamp": timestamp
  };

  @override
  String toString() {
    return 'Message{msg: $msg, timestamp: $timestamp}';
  }

}
