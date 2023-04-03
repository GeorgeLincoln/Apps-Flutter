// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_LoginStore.emailValid'))
          .value;
  Computed<bool> _$passwordValidComputed;

  @override
  bool get passwordValid =>
      (_$passwordValidComputed ??= Computed<bool>(() => super.passwordValid,
              name: '_LoginStore.passwordValid'))
          .value;
  Computed<Function> _$loginPressedComputed;

  @override
  Function get loginPressed =>
      (_$loginPressedComputed ??= Computed<Function>(() => super.loginPressed,
              name: '_LoginStore.loginPressed'))
          .value;
  Computed<Function> _$facebookPressedComputed;

  @override
  Function get facebookPressed => (_$facebookPressedComputed ??=
          Computed<Function>(() => super.facebookPressed,
              name: '_LoginStore.facebookPressed'))
      .value;
  Computed<Function> _$savePhonePressedComputed;

  @override
  Function get savePhonePressed => (_$savePhonePressedComputed ??=
          Computed<Function>(() => super.savePhonePressed,
              name: '_LoginStore.savePhonePressed'))
      .value;
  Computed<bool> _$phoneValidComputed;

  @override
  bool get phoneValid =>
      (_$phoneValidComputed ??= Computed<bool>(() => super.phoneValid,
              name: '_LoginStore.phoneValid'))
          .value;

  final _$emailAtom = Atom(name: '_LoginStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginStore.loading');

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

  final _$errorAtom = Atom(name: '_LoginStore.error');

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

  final _$loadingFaceAtom = Atom(name: '_LoginStore.loadingFace');

  @override
  bool get loadingFace {
    _$loadingFaceAtom.reportRead();
    return super.loadingFace;
  }

  @override
  set loadingFace(bool value) {
    _$loadingFaceAtom.reportWrite(value, super.loadingFace, () {
      super.loadingFace = value;
    });
  }

  final _$phoneAtom = Atom(name: '_LoginStore.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$_loginAsyncAction = AsyncAction('_LoginStore._login');

  @override
  Future<void> _login() {
    return _$_loginAsyncAction.run(() => super._login());
  }

  final _$_facebookAsyncAction = AsyncAction('_LoginStore._facebook');

  @override
  Future<void> _facebook() {
    return _$_facebookAsyncAction.run(() => super._facebook());
  }

  final _$_savePhoneAsyncAction = AsyncAction('_LoginStore._savePhone');

  @override
  Future<void> _savePhone() {
    return _$_savePhoneAsyncAction.run(() => super._savePhone());
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
loading: ${loading},
error: ${error},
loadingFace: ${loadingFace},
phone: ${phone},
emailValid: ${emailValid},
passwordValid: ${passwordValid},
loginPressed: ${loginPressed},
facebookPressed: ${facebookPressed},
savePhonePressed: ${savePhonePressed},
phoneValid: ${phoneValid}
    ''';
  }
}
