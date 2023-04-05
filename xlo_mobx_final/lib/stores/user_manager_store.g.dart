// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manager_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserManagerStore on _UserManagerStore, Store {
  Computed<bool> _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: '_UserManagerStore.isLoggedIn'))
          .value;

  final _$userAtom = Atom(name: '_UserManagerStore.user');

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$readyToFetchAdsAtom = Atom(name: '_UserManagerStore.readyToFetchAds');

  @override
  bool get readyToFetchAds {
    _$readyToFetchAdsAtom.reportRead();
    return super.readyToFetchAds;
  }

  @override
  set readyToFetchAds(bool value) {
    _$readyToFetchAdsAtom.reportWrite(value, super.readyToFetchAds, () {
      super.readyToFetchAds = value;
    });
  }

  final _$_UserManagerStoreActionController =
      ActionController(name: '_UserManagerStore');

  @override
  dynamic setReadyToFetchAds(bool value) {
    final _$actionInfo = _$_UserManagerStoreActionController.startAction(
        name: '_UserManagerStore.setReadyToFetchAds');
    try {
      return super.setReadyToFetchAds(value);
    } finally {
      _$_UserManagerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUser(User value) {
    final _$actionInfo = _$_UserManagerStoreActionController.startAction(
        name: '_UserManagerStore.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_UserManagerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
readyToFetchAds: ${readyToFetchAds},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
