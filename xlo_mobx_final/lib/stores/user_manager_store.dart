import 'package:mobx/mobx.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {
  _UserManagerStore() {
    _getCurrentUser();
  }

  @observable
  User user;

  @observable
  bool readyToFetchAds;

  @action
  setReadyToFetchAds(bool value) => readyToFetchAds = value;

  @action
  void setUser(User value) {
    user = value;
    updateUserOneSignal(user);
  }

  @computed
  bool get isLoggedIn => user != null;

  Future<void> _getCurrentUser() async {
    setReadyToFetchAds(false);
    final user = await UserRepository().currentUser();
    setUser(user);
    setReadyToFetchAds(true);
  }

  Future<void> logout() async {
    await UserRepository().logout();
    setUser(null);
  }

  void updateUserOneSignal(User user) {
    if (user != null) {
      OneSignal.shared.setExternalUserId(user.id);
    } else {
      OneSignal.shared.removeExternalUserId();
    }
  }
}
