// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LocationStore on _LocationStore, Store {
  Computed<bool> _$showLocationScreenComputed;

  @override
  bool get showLocationScreen => (_$showLocationScreenComputed ??=
          Computed<bool>(() => super.showLocationScreen,
              name: '_LocationStore.showLocationScreen'))
      .value;
  Computed<bool> _$exitLocationScreenComputed;

  @override
  bool get exitLocationScreen => (_$exitLocationScreenComputed ??=
          Computed<bool>(() => super.exitLocationScreen,
              name: '_LocationStore.exitLocationScreen'))
      .value;
  Computed<bool> _$readyToFetchAdsComputed;

  @override
  bool get readyToFetchAds =>
      (_$readyToFetchAdsComputed ??= Computed<bool>(() => super.readyToFetchAds,
              name: '_LocationStore.readyToFetchAds'))
          .value;

  final _$locationAtom = Atom(name: '_LocationStore.location');

  @override
  Address get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(Address value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$statusAtom = Atom(name: '_LocationStore.status');

  @override
  LocationStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(LocationStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_LocationStoreActionController =
      ActionController(name: '_LocationStore');

  @override
  void setLocation(Address value) {
    final _$actionInfo = _$_LocationStoreActionController.startAction(
        name: '_LocationStore.setLocation');
    try {
      return super.setLocation(value);
    } finally {
      _$_LocationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatus(LocationStatus value) {
    final _$actionInfo = _$_LocationStoreActionController.startAction(
        name: '_LocationStore.setStatus');
    try {
      return super.setStatus(value);
    } finally {
      _$_LocationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
location: ${location},
status: ${status},
showLocationScreen: ${showLocationScreen},
exitLocationScreen: ${exitLocationScreen},
readyToFetchAds: ${readyToFetchAds}
    ''';
  }
}
