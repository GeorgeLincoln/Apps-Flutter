// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatRoomStore on _ChatRoomStore, Store {
  Computed<ChatRoom> _$chatRoomComputed;

  @override
  ChatRoom get chatRoom =>
      (_$chatRoomComputed ??= Computed<ChatRoom>(() => super.chatRoom,
              name: '_ChatRoomStore.chatRoom'))
          .value;
  Computed<Ad> _$adComputed;

  @override
  Ad get ad =>
      (_$adComputed ??= Computed<Ad>(() => super.ad, name: '_ChatRoomStore.ad'))
          .value;
  Computed<List<User>> _$usersComputed;

  @override
  List<User> get users => (_$usersComputed ??=
          Computed<List<User>>(() => super.users, name: '_ChatRoomStore.users'))
      .value;

  final _$_chatRoomAtom = Atom(name: '_ChatRoomStore._chatRoom');

  @override
  ChatRoom get _chatRoom {
    _$_chatRoomAtom.reportRead();
    return super._chatRoom;
  }

  @override
  set _chatRoom(ChatRoom value) {
    _$_chatRoomAtom.reportWrite(value, super._chatRoom, () {
      super._chatRoom = value;
    });
  }

  final _$_adAtom = Atom(name: '_ChatRoomStore._ad');

  @override
  Ad get _ad {
    _$_adAtom.reportRead();
    return super._ad;
  }

  @override
  set _ad(Ad value) {
    _$_adAtom.reportWrite(value, super._ad, () {
      super._ad = value;
    });
  }

  final _$chatRoomListAtom = Atom(name: '_ChatRoomStore.chatRoomList');

  @override
  ObservableList<ChatRoom> get chatRoomList {
    _$chatRoomListAtom.reportRead();
    return super.chatRoomList;
  }

  @override
  set chatRoomList(ObservableList<ChatRoom> value) {
    _$chatRoomListAtom.reportWrite(value, super.chatRoomList, () {
      super.chatRoomList = value;
    });
  }

  final _$_getChatRoomListAsyncAction =
      AsyncAction('_ChatRoomStore._getChatRoomList');

  @override
  Future<void> _getChatRoomList() {
    return _$_getChatRoomListAsyncAction.run(() => super._getChatRoomList());
  }

  final _$_liveChatRoomListAsyncAction =
      AsyncAction('_ChatRoomStore._liveChatRoomList');

  @override
  Future _liveChatRoomList() {
    return _$_liveChatRoomListAsyncAction.run(() => super._liveChatRoomList());
  }

  final _$createChatRoomAsyncAction =
      AsyncAction('_ChatRoomStore.createChatRoom');

  @override
  Future<ChatRoom> createChatRoom({@required Ad ad}) {
    return _$createChatRoomAsyncAction.run(() => super.createChatRoom(ad: ad));
  }

  final _$_ChatRoomStoreActionController =
      ActionController(name: '_ChatRoomStore');

  @override
  dynamic setChatRoom(ChatRoom value) {
    final _$actionInfo = _$_ChatRoomStoreActionController.startAction(
        name: '_ChatRoomStore.setChatRoom');
    try {
      return super.setChatRoom(value);
    } finally {
      _$_ChatRoomStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAd(Ad value) {
    final _$actionInfo = _$_ChatRoomStoreActionController.startAction(
        name: '_ChatRoomStore.setAd');
    try {
      return super.setAd(value);
    } finally {
      _$_ChatRoomStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chatRoomList: ${chatRoomList},
chatRoom: ${chatRoom},
ad: ${ad},
users: ${users}
    ''';
  }
}
