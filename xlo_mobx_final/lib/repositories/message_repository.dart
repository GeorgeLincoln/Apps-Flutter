import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/chatroom.dart';
import 'package:xlo_mobx/models/messages.dart';
import 'package:xlo_mobx/models/user.dart';

import 'parse_errors.dart';
import 'table_keys.dart';

class MessageRepository {
  LiveQuery _liveQuery = LiveQuery();
  Subscription _subscription;

  QueryBuilder getQuery(String chatRoomId) =>
      QueryBuilder<ParseObject>(ParseObject(keyMessageTable))
        ..whereEqualTo(
            KeyMessageChatRoom,
            (ParseObject(keyChatRoomTable)..set(keyChatRoomId, chatRoomId))
                .toPointer())
        ..orderByDescending(KeyMessageDateSend);

  Future<List<Message>> getMessagesList(ChatRoom chatRoom) async {
    try {
      final response = await getQuery(chatRoom.id).query();
      if (response.success && response.results != null) {
        return response.results.map((m) => Message.fromParse(m)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha ao recuperar lista de mensagens');
    }
  }

  Future<void> liveMessageList(
      {@required ChatRoom chatRoom, @required Function onNewMessage}) async {
    _subscription = await _liveQuery.client.subscribe(getQuery(chatRoom.id));

    _subscription.on(LiveQueryEvent.create, (object) {
      onNewMessage(Message.fromParse(object));
    });
  }

  Future<Message> saveMessage(
      {@required ChatRoom chatRoom,
      @required String textMessage,
      @required List<User> users,
      @required User destination}) async {
    try {
      final messageObject = ParseObject(keyMessageTable);

      List<ParseUser> _users = users
          .map((u) => ParseUser(null, null, null)..objectId = u.id)
          .toList();

      final parseAcl = ParseACL();
      _users.forEach((u) {
        parseAcl
          ..setWriteAccess(userId: u.objectId)
          ..setReadAccess(userId: u.objectId);
      });

      messageObject
        ..set(KeyMessageChatRoom,
            ParseObject(keyChatRoomTable)..set(keyChatRoomId, chatRoom.id))
        ..setACL(parseAcl)
        ..set(keyMessageDestinationId, destination.id)
        ..set(keyMessageText, textMessage);

      final response = await messageObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }

      return Message.fromParse(response.results.first);
    } catch (e) {
      return Future.error('Falha ao enviar a mensagem');
    }
  }

  void cancelLiveQuery() {
    if (_subscription != null) {
      _liveQuery.client.unSubscribe(_subscription);
    }
    _subscription = null;
  }
}
