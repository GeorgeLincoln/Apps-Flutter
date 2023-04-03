import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class Message {
  String id;
  String chatRoomId;
  String text;
  String destinationId;
  DateTime sendDate;

  Message(
      {@required this.id,
      @required this.chatRoomId,
      @required this.text,
      @required this.destinationId,
      @required this.sendDate});

  Message.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    chatRoomId = parseObject.get<ParseObject>(KeyMessageChatRoom).objectId;
    text = parseObject.get<String>(keyMessageText);
    sendDate = parseObject.get<DateTime>(KeyMessageDateSend);
    destinationId = parseObject.get<String>(keyMessageDestinationId);
  }
}
