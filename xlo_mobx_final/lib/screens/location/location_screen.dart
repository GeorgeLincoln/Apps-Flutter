import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/replace_raisedbutton.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/screens/uf_city/uf_city_screen.dart';
import 'package:xlo_mobx/stores/location_store.dart';

import 'components/location_info_dialog.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.showInfoDialog = false});

  final bool showInfoDialog;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
  bool get showInfoDialog => widget.showInfoDialog;

  AnimationController _animController;
  Animation<double> _circleAnim;

  final LocationStore locationStore = GetIt.I<LocationStore>();

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _circleAnim = Tween<double>(begin: 70.0, end: 300).animate(_animController);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.forward(from: 0);
      }
    });

    _animController.forward(from: 0);

    if (showInfoDialog)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(
          context: context,
          builder: (context) => LocationInfoDialog(),
        );
        await locationStore.getLocation();
      });

    reaction((_) => locationStore.exitLocationScreen, (s) {
      if (s) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: AnimatedBuilder(
            animation: _circleAnim,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  Observer(
                    builder: (_) {
                      if (locationStore.status == LocationStatus.FAILED) {
                        return Positioned.fill(
                          child: Container(
                            child: Text(
                              ':( Ops!\n Não identificamos\nsua localização!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                        );
                      }
                      return Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: _circleAnim.value,
                              height: _circleAnim.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: _circleAnim.value - 5,
                              height: _circleAnim.value - 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.purple,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Positioned(
                    top: 55,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.purple,
                          size: 55,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Text(
                          'Buscando sua\nlocalização atual',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            'Selecionar manualmente:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Container(
                          height: 56,
                          child: ReplaceRaisedButton(
                            onPressed: selectManually,
                            color: Colors.purple,
                            child: Text(
                              'Escolher estado',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> selectManually() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => UfCityScreen()));
    if (result != null) {
      locationStore
          .setLocation(Address(city: result['city'], uf: result['uf']));
    }
  }
}
