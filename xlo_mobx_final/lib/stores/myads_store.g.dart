// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myads_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyAdsStore on _MyAdsStore, Store {
  Computed<List<Ad>> _$activeAdsComputed;

  @override
  List<Ad> get activeAds =>
      (_$activeAdsComputed ??= Computed<List<Ad>>(() => super.activeAds,
              name: '_MyAdsStore.activeAds'))
          .value;

  final _$allAdsAtom = Atom(name: '_MyAdsStore.allAds');

  @override
  List<Ad> get allAds {
    _$allAdsAtom.reportRead();
    return super.allAds;
  }

  @override
  set allAds(List<Ad> value) {
    _$allAdsAtom.reportWrite(value, super.allAds, () {
      super.allAds = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MyAdsStore.loading');

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

  final _$soldAdAsyncAction = AsyncAction('_MyAdsStore.soldAd');

  @override
  Future<void> soldAd(Ad ad) {
    return _$soldAdAsyncAction.run(() => super.soldAd(ad));
  }

  final _$deleteAdAsyncAction = AsyncAction('_MyAdsStore.deleteAd');

  @override
  Future<void> deleteAd(Ad ad) {
    return _$deleteAdAsyncAction.run(() => super.deleteAd(ad));
  }

  @override
  String toString() {
    return '''
allAds: ${allAds},
loading: ${loading},
activeAds: ${activeAds}
    ''';
  }
}
