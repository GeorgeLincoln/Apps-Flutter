// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on _MessageStore, Store {
  final _$loadingAtom = Atom(name: '_MessageStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_MessageStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$messageListAtom = Atom(name: '_MessageStore.messageList');

  @override
  ObservableList<Message> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(ObservableList<Message> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  final _$getMessagesListAsyncAction =
      AsyncAction('_MessageStore.getMessagesList');

  @override
  Future getMessagesList() {
    return _$getMessagesListAsyncAction.run(() => super.getMessagesList());
  }

  final _$liveMessageListAsyncAction =
      AsyncAction('_MessageStore.liveMessageList');

  @override
  Future liveMessageList() {
    return _$liveMessageListAsyncAction.run(() => super.liveMessageList());
  }

  final _$sendMessageAsyncAction = AsyncAction('_MessageStore.sendMessage');

  @override
  Future sendMessage(String message) {
    return _$sendMessageAsyncAction.run(() => super.sendMessage(message));
  }

  final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String value) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
messageList: ${messageList}
    ''';
  }
}
