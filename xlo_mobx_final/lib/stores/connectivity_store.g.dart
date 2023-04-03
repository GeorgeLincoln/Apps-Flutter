// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectivityStore on _ConnectivityStore, Store {
  final _$connectedAtom = Atom(name: '_ConnectivityStore.connected');

  @override
  bool get connected {
    _$connectedAtom.reportRead();
    return super.connected;
  }

  @override
  set connected(bool value) {
    _$connectedAtom.reportWrite(value, super.connected, () {
      super.connected = value;
    });
  }

  final _$_ConnectivityStoreActionController =
      ActionController(name: '_ConnectivityStore');

  @override
  void setConnected(bool value) {
    final _$actionInfo = _$_ConnectivityStoreActionController.startAction(
        name: '_ConnectivityStore.setConnected');
    try {
      return super.setConnected(value);
    } finally {
      _$_ConnectivityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
connected: ${connected}
    ''';
  }
}
