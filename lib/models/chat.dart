class Chat {
  final String myUid;
  final String myName;
  final String otherUid;
  final String otherName;
  final String chatId;
  final String lastMsg;
  final String lastMsgTime;

  Chat(
      {required this.chatId,
        required this.myUid,
        required this.otherUid,
        required this.myName,
        required this.otherName,
        required this.lastMsg,
        required this.lastMsgTime
      });

  // from JSON
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: json['chatId'],
      myUid: json['myUid'],
      myName: json['myName'],
      otherUid: json['otherUid'],
      otherName: json['otherName'],
      lastMsg: json['lastMsg'],
      lastMsgTime: json['lastMsgTime'],
    );
  }
  // to JSON
  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'myUid': myUid,
    'otherUid': otherUid,
    'myName': myName,
    'otherName': otherName,
    'lastMsg': lastMsg,
    'lastMsgTime': lastMsgTime,
  };
}
