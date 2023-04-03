import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/replace_raisedbutton.dart';
import 'package:xlo_mobx/stores/login_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class PhoneScreen extends StatefulWidget {
  PhoneScreen(this.loginStore);

  final LoginStore loginStore;

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => userManagerStore.user, (u) {
      if (u != null && u.phone != null && u.phone.isNotEmpty)
        Navigator.of(context).pop();
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
        appBar: AppBar(
          title: const Text('Confirme seu telefone'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
            margin: const EdgeInsets.all(32),
            alignment: Alignment.center,
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
                      const SizedBox(
                        height: 16,
                      ),
                      Icon(
                        Icons.phone,
                        size: 100,
                        color: Colors.purple,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Para garantir a segurança da sua conta, insira seu celular.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Observer(
                        builder: (_) {
                          return TextFormField(
                            keyboardType: TextInputType.phone,
                            textAlign: TextAlign.center,
                            enabled: !widget.loginStore.loading,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '(21) 99999-9999',
                              isDense: true,
                              errorText: widget.loginStore.phoneError,
                            ),
                            onChanged: widget.loginStore.setPhone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                          );
                        },
                      ),
                      Observer(
                        builder: (_) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            height: 40,
                            child: ReplaceRaisedButton(
                              color: Colors.orange,
                              disabledColor: Colors.orange.withAlpha(120),
                              child: widget.loginStore.loading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    )
                                  : Text('Salvar'),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: widget.loginStore.savePhonePressed,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
