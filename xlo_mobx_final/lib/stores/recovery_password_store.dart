import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

part 'recovery_password_store.g.dart';

class RecoveryPasswordStore = _RecoveryPasswordStore
    with _$RecoveryPasswordStore;

abstract class _RecoveryPasswordStore with Store {
  _RecoveryPasswordStore(String email) {
    this.email = email;
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (email == null || emailValid)
      return null;
    else if (email.isEmpty)
      return 'Campo obrigatório';
    else
      return 'E-mail inválido';
  }

  @computed
  Function get recoverPressed => (emailValid && !loading) ? _recover : null;

  @observable
  bool success = false;

  @action
  void setSuccess(bool value) => success = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  Future<void> _recover() async {
    setLoading(true);

    try {
      await UserRepository().recoverPassword(email);
      setSuccess(true);
    } catch (_) {
      setError(error);
    }

    setLoading(false);
  }
}
