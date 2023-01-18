import 'dart:async';

import 'package:aquicultura_transporte/validators/login_validators.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL}

class LoginBloc extends BlocBase with LoginValidators{
  
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outSenha => _senhaController.stream.transform(validateSenha);
  Stream<LoginState> get outState => _stateController.stream;
  Stream<bool>   get outSubmitValid => Observable.combineLatest2(
    outEmail, outSenha, (a, b)=> true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeSenha => _senhaController.sink.add;

  StreamSubscription _streamSubscription;

  LoginBloc(){
    //FirebaseAuth.instance.signOut();
    _streamSubscription =  FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      if(user!= null){
        print("Usuário: " + user.email + " logou");
        if(await verificaPrevilegios(user)){
          _stateController.add(LoginState.SUCCESS);
        }else{
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginState.FAIL);
        }

      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit(){
    final email = _emailController.value;
    final senha = _senhaController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: senha
    ).catchError((e){
      _stateController.add(LoginState.FAIL);
    });

  }

   Future<bool> verificaPrevilegios(FirebaseUser user) async {
    return await Firestore.instance.collection("admins").document(user.uid).get().then((doc){
      if(doc.data != null){
        return true;
      }else{
        return false;
      }
    }).catchError((e){
      return false;
    });
  }

  @override
  void dispose(){
    _emailController.close();
    _senhaController.close();
    _stateController.close();

    _streamSubscription.cancel();
  }
}