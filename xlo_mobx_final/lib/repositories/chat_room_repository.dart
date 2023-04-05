import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/chatroom.dart';
import 'package:xlo_mobx/models/user.dart';

import 'parse_errors.dart';
import 'table_keys.dart';

class ChatRoomRepository {
  LiveQuery _liveQuery = LiveQuery(autoSendSessionId: true);
  Subscription _subscription;

  QueryBuilder getQuery(User user) =>
      QueryBuilder<ParseObject>(ParseObject(keyChatRoomTable))
        ..includeObject(
            [keyChatRoomAd, keyChatRoomUsers, '$keyChatRoomAd.$keyAdOwner'])
        ..orderByDescending(keyChatRoomLastDateMessage);

  Future<List<ChatRoom>> getChatRoomList(User user) async {
    try {
      final response = await getQuery(user).query();

      if (response.success && response.results != null) {
        return response.results.map((c) => ChatRoom.fromParse(c)).toList();
      } else if (response.success && response.results == null) {
        return [];
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha ao recuperar lista sala de chat');
    }
  }

  Future<ChatRoom> getChatRoomById(String id) async {
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyChatRoomTable))
            ..includeObject(
                [keyChatRoomAd, keyChatRoomUsers, '$keyChatRoomAd.$keyAdOwner'])
            ..whereEqualTo(keyChatRoomId, id);

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        return ChatRoom.fromParse(response.results.first);
      } else if (response.success && response.results == null) {
        return null;
      } else {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha ao recuperar lista sala de chat');
    }
  }

  Future<void> liveChatRoomList(
      {@required User user, @required Function onChange}) async {
    _subscription = await _liveQuery.client.subscribe(getQuery(user));

    //Registro novo
    _subscription.on(LiveQueryEvent.create, (object) {
      onChange();
    });

    //Registro atualizado
    _subscription.on(LiveQueryEvent.update, (object) {
      onChange();
    });

    //Registro excluído
    _subscription.on(LiveQueryEvent.delete, (object) {
      onChange();
    });
  }

  Future<ChatRoom> createChatRoom(
      {@required Ad ad, @required List<User> users}) async {
    try {
      final chatRoomObject = ParseObject(keyChatRoomTable);

      List<ParseUser> _users = users
          .map((u) => ParseUser(null, null, null)..objectId = u.id)
          .toList();

      final parseAcl = ParseACL();
      _users.forEach((u) {
        parseAcl
          ..setWriteAccess(userId: u.objectId)
          ..setReadAccess(userId: u.objectId);
      });

      chatRoomObject
        ..setACL(parseAcl)
        ..set(keyChatRoomUsers, _users)
        ..set(keyChatRoomAd, ParseObject(keyAdTable)..set(keyAdId, ad.id));

      final response = await chatRoomObject.save();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }

      return await getChatRoomById(
          (response.results.first as ParseObject).objectId);
    } catch (e) {
      return Future.error('Falha ao criar sala de batepapo');
    }
  }

  Future<void> deleteChatRoom(ChatRoom chatRoom) async {
    try {
      final chatRoomObject = ParseObject(keyChatRoomTable);

      chatRoomObject..objectId = chatRoom.id;

      final response = await chatRoomObject.delete();

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
    } catch (e) {
      return Future.error('Falha ao excluir sala de batepapo');
    }
  }

  void cancelLiveQuery() {
    if (_subscription != null) {
      _liveQuery.client.unSubscribe(_subscription);
    }
    _subscription = null;
  }
}
