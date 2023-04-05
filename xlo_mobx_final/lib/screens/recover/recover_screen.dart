import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/components/replace_raisedbutton.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/recovery_password_store.dart';

class RecoverScreen extends StatefulWidget {
  RecoverScreen(this.email);

  final String email;

  @override
  _RecoverScreenState createState() => _RecoverScreenState(email);
}

class _RecoverScreenState extends State<RecoverScreen> {
  _RecoverScreenState(String email)
      : recoverStore = RecoveryPasswordStore(email);

  final RecoveryPasswordStore recoverStore;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => recoverStore.success, (s) {
      if (s)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Link de recuperação enviado para o E-mail informado',
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
        ));
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          title: const Text('Recuperar Senha'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(
                      builder: (_) {
                        if (recoverStore.error != null)
                          return ErrorBox(
                            message: recoverStore.error,
                          );
                        else
                          return const SizedBox(
                            height: 8,
                          );
                      },
                    ),
                    FieldTitle(
                      title: 'Confirme seu E-mail',
                      subtitle: 'Enviaremos um link para recuperaçao',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) {
                        return TextFormField(
                          initialValue: recoverStore.email,
                          enabled: !recoverStore.loading,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Exemplo: joao@gmail.com',
                            isDense: true,
                            errorText: recoverStore.emailError,
                          ),
                          onChanged: recoverStore.setEmail,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Observer(
                      builder: (_) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          height: 40,
                          child: ReplaceRaisedButton(
                            color: Colors.orange,
                            child: recoverStore.loading
                                ? CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text(
                                    'Cadastre-se',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            elevation: 0,
                            onPressed: recoverStore.recoverPressed,
                            disabledColor: Colors.orange.withAlpha(120),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
