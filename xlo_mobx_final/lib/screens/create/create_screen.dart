import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/components/replace_raisedbutton.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/myads/myads_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  CreateScreen({this.ad});

  final Ad ad;

  @override
  _CreateScreenState createState() => _CreateScreenState(ad);
}

class _CreateScreenState extends State<CreateScreen> {
  _CreateScreenState(Ad ad)
      : editing = ad != null,
        createStore = CreateStore(ad ?? Ad());

  final CreateStore createStore;

  bool editing;

  @override
  void initState() {
    super.initState();

    when((_) => createStore.savedAd, () {
      if (editing)
        Navigator.of(context).pop(true);
      else {
        GetIt.I<PageStore>().setPage(0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MyAdsScreen(initialPage: 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.grey,
      fontSize: 18,
    );

    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: editing ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text(editing ? 'Editar Anúncio' : 'Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Observer(builder: (_) {
              if (createStore.loading)
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Salvando Anúncio',
                        style: TextStyle(fontSize: 18, color: Colors.purple),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.purple),
                      )
                    ],
                  ),
                );
              else
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagesField(createStore),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createStore.title,
                        onChanged: createStore.setTitle,
                        decoration: InputDecoration(
                          labelText: 'Título *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                          errorText: createStore.titleError,
                        ),
                      );
                    }),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createStore.description,
                        onChanged: createStore.setDescription,
                        decoration: InputDecoration(
                          labelText: 'Descrição *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                          errorText: createStore.descriptionError,
                        ),
                        maxLines: null,
                      );
                    }),
                    CategoryField(createStore),
                    CepField(createStore),
                    Observer(builder: (_) {
                      return TextFormField(
                        initialValue: createStore.priceText,
                        onChanged: createStore.setPrice,
                        decoration: InputDecoration(
                          labelText: 'Preço *',
                          labelStyle: labelStyle,
                          contentPadding: contentPadding,
                          prefixText: 'R\$ ',
                          errorText: createStore.priceError,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RealInputFormatter(centavos: true),
                        ],
                      );
                    }),
                    HidePhoneField(createStore),
                    Observer(builder: (_) {
                      return ErrorBox(
                        message: createStore.error,
                      );
                    }),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: createStore.invalidSendPressed,
                          child: ReplaceRaisedButton(
                            child: Text(
                              'Enviar',
                              style: TextStyle(fontSize: 18),
                            ),
                            textColor: Colors.white,
                            color: Colors.orange,
                            disabledColor: Colors.orange.withAlpha(120),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: createStore.sendPressed,
                          ),
                        ),
                      );
                    }),
                  ],
                );
            }),
          ),
        ),
      ),
    );
  }
}
