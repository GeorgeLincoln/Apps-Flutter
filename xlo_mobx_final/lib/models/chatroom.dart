import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

import 'ad.dart';

class ChatRoom {
  String id;
  Ad ad;
  String lastMessageText;
  DateTime lastDateTimeMessage;
  List<User> users;

  ChatRoom(
      {@required this.id,
      @required this.ad,
      @required this.lastMessageText,
      @required this.lastDateTimeMessage,
      @required this.users});

  ChatRoom.fromParse(ParseObject parseObject) {
    id = parseObject.objectId;
    ad = Ad.fromParse(parseObject.get<ParseObject>(keyChatRoomAd));
    lastMessageText =
        parseObject.get<String>(KeyChatRoomLastMessage, defaultValue: '');
    lastDateTimeMessage = parseObject.get<DateTime>(keyChatRoomLastDateMessage);
    /*
    users = parseObject
        .get<List<dynamic>>(keyChatRoomUsers)
        .map((u) => User(id: (u as ParseUser).objectId))
        .toList();
     */

    users = parseObject
        .get<List<dynamic>>(keyChatRoomUsers)
        .map((u) => UserRepository().mapParseToUser(u))
        .toList();
  }
}
