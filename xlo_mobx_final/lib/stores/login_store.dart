import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passwordValid => password != null && password.length >= 4;
  String get passwordError =>
      password == null || passwordValid ? null : 'Senha inválida';

  @computed
  Function get loginPressed =>
      emailValid && passwordValid && !loading ? _login : null;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool loadingFace = false;

  @computed
  Function get facebookPressed => !loading ? _facebook : null;

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  Function get savePhonePressed => (phoneValid && !loading) ? _savePhone : null;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (phone == null || phoneValid)
      return null;
    else if (phone.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Celular inválido';
  }

  @action
  Future<void> _login() async {
    loading = true;
    error = null;

    try {
      final user = await UserRepository().loginWithEmail(email, password);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e;
    }

    loading = false;
  }

  @action
  Future<void> _facebook() async {
    loadingFace = true;

    try {
      final user = await UserRepository().loginWithFacebook();
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e;
    }

    loadingFace = false;
  }

  @action
  Future<void> _savePhone() async {
    loadingFace = true;

    final user = GetIt.I<UserManagerStore>().user.copyWith(phone: phone);

    try {
      await UserRepository().save(user);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      print(e);
    }

    loadingFace = false;
  }
}
