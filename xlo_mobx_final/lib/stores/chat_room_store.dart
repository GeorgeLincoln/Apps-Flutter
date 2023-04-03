import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/chatroom.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/chat_room_repository.dart';

import 'user_manager_store.dart';

part 'chat_room_store.g.dart';

class ChatRoomStore = _ChatRoomStore with _$ChatRoomStore;

abstract class _ChatRoomStore with Store {
  _ChatRoomStore() {
    reaction((_) => userManagerStore.isLoggedIn, (u) {
      chatRoomList.clear();
      if (u) {
        _getChatRoomList();
        _liveChatRoomList();
      } else {
        _cancelLive();
      }
    });
  }

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final ChatRoomRepository chatRoomRepository = ChatRoomRepository();

  @observable
  ChatRoom _chatRoom;

  @observable
  Ad _ad;

  @observable
  ObservableList<ChatRoom> chatRoomList = ObservableList<ChatRoom>();

  @action
  setChatRoom(ChatRoom value) => _chatRoom = value;

  @action
  setAd(Ad value) => _ad = value;

  @computed
  ChatRoom get chatRoom {
    if (_chatRoom != null) {
      isNew = false;
      return _chatRoom;
    }

    if (_ad != null) {
      if (chatRoomList.any((c) => c.ad.id == _ad.id)) {
        isNew = false;
        return chatRoomList.firstWhere((c) => c.ad.id == _ad.id);
      }
    }
    isNew = true;
    return null;
  }

  @computed
  Ad get ad {
    if (_chatRoom != null) {
      return _chatRoom.ad;
    } else {
      return _ad;
    }
  }

  @computed
  List<User> get users {
    if (_chatRoom != null) {
      return _chatRoom.users;
    } else {
      return [userManagerStore.user, _ad.user];
    }
  }

  User get sender => userManagerStore.user;

  User get destination => users.firstWhere((user) => user.id != sender.id);

  bool isNew = false;

  @action
  Future<void> _getChatRoomList() async {
    try {
      final chatRooms =
          await chatRoomRepository.getChatRoomList(userManagerStore.user);
      chatRoomList.clear();
      chatRoomList.addAll(chatRooms);
    } catch (e) {
      print(e);
    }
  }

  @action
  _liveChatRoomList() async {
    await chatRoomRepository.liveChatRoomList(
        user: userManagerStore.user, onChange: () => _getChatRoomList());
  }

  _cancelLive() {
    chatRoomRepository.cancelLiveQuery();
  }

  void cancelLive() {
    _cancelLive();
  }

  void deleteChatRom(ChatRoom chatRoom) async {
    await chatRoomRepository.deleteChatRoom(chatRoom);
  }

  @action
  Future<ChatRoom> createChatRoom({@required Ad ad}) async {
    try {
      isNew = true;

      final ChatRoom chatRoom =
          await chatRoomRepository.createChatRoom(ad: ad, users: users);
      setChatRoom(chatRoom);
      return chatRoom;
    } catch (e) {
      return null;
    }
  }
}
