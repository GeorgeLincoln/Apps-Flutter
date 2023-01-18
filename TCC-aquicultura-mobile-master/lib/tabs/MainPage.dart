import 'dart:async';
import 'package:aquicultura_transporte/widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

import './DiscoveryPage.dart';
import './SelectBondedDevicePage.dart';
import './ChatPage.dart';
import './BackgroundCollectingTask.dart';
import './BackgroundCollectedPage.dart';

//import './LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: new Text('Move-Aqua'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Divider(),
            SwitchListTile(
              title: const Text('Habilitar Bluetooth'),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('Status do Bluetooth'),
              subtitle: Text(_bluetoothState.toString()),
              trailing: RaisedButton(
                child: const Text('Configurações'),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
            // ListTile(
            //   title: const Text('Local adapter address'),
            //   subtitle: Text(_address),
            // ),
            // ListTile(
            //   title: const Text('Local adapter name'),
            //   subtitle: Text(_name),
            //   onLongPress: null,
            // ),
            Divider(),
            SwitchListTile(
              title: _discoverableTimeoutSecondsLeft == 0
                  ? const Text("Tornar visível")
                  : Text("Visível por ${_discoverableTimeoutSecondsLeft}s"),
              value: _discoverableTimeoutSecondsLeft != 0,
              onChanged: (bool value) async {
                if (value) {
                  print('Modo visível requerido');
                  final int timeout = await FlutterBluetoothSerial.instance
                      .requestDiscoverable(60);
                  if (timeout < 0) {
                    print('Modo visível negado');
                  } else {
                    print('Modo visível por $timeout segundos');
                  }
                  setState(() {
                    _discoverableTimeoutTimer?.cancel();
                    _discoverableTimeoutSecondsLeft = timeout;
                    _discoverableTimeoutTimer =
                        Timer.periodic(Duration(seconds: 1), (Timer timer) {
                      setState(() {
                        if (_discoverableTimeoutSecondsLeft < 0) {
                          FlutterBluetoothSerial.instance.isDiscoverable
                              .then((isDiscoverable) {
                                if (isDiscoverable) {
                                  print(
                                      "Discoverable after timeout... might be infinity timeout :F");
                                  _discoverableTimeoutSecondsLeft = 0;
                                }
                              });
                          timer.cancel();
                          _discoverableTimeoutSecondsLeft = 0;
                          } else {
                            _discoverableTimeoutSecondsLeft -= 1;
                        }
                      });
                    });
                  });
                } else {
                  _discoverableTimeoutSecondsLeft = 0;
                }
              },
            ),
            

            Divider(),
            ListTile(title: const Text('Buscando e conectando dispositivos')),
            SwitchListTile(
              title: const Text(
                  'Tente automaticamente o pino específico ao parear'),
              subtitle: const Text('Pin 1234'),
              value: _autoAcceptPairingRequests,
              onChanged: (bool value) {
                setState(() {
                  _autoAcceptPairingRequests = value;
                });
                if (value) {
                  FlutterBluetoothSerial.instance.setPairingRequestHandler(
                      (BluetoothPairingRequest request) {
                    print("Tentando parear automaticamente com o Pin 1234");
                    if (request.pairingVariant == PairingVariant.Pin) {
                      return Future.value("1234");
                    }
                    return null;
                  });
                } else {
                  FlutterBluetoothSerial.instance
                      .setPairingRequestHandler(null);
                }
              },
            ),
            ListTile(
              title: RaisedButton(
                  child: const Text('Buscar dispositivos'),
                  onPressed: () async {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                      return DiscoveryPage();
                    }));

                    if (selectedDevice != null) {
                      print('Buscado -> selecionado ' + selectedDevice.address);
                    } else {
                      print('Buscado -> nenhum dispositivo selecionado');
                    }
                  }),
            ),
            // ListTile(
            //   title: RaisedButton(
            //     child: const Text('Conecte-se ao dispositivo pareado para conversar'),
            //     onPressed: () async {
            //       final BluetoothDevice selectedDevice = await Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) { return SelectBondedDevicePage(checkAvailability: false); })
            //       );

            //       if (selectedDevice != null) {
            //         print('Conectar -> selecionado ' + selectedDevice.address);
            //         _startChat(context, selectedDevice);
            //       }
            //       else {
            //         print('Conectar -> nenhum dispositivo selecionado');
            //       }
            //     },
            //   ),
            // ),

            Divider(),
            ListTile(title: const Text('Várias conexões')),
            ListTile(
              title: RaisedButton(
                child: ((_collectingTask != null && _collectingTask.inProgress)
                    ? const Text(
                        'Desconectar e interromper a coleta em segundo plano')
                    : const Text(
                        'Conecte-se para iniciar a coleta em segundo plano')),
                onPressed: () async {
                  if (_collectingTask != null && _collectingTask.inProgress) {
                    await _collectingTask.cancel();
                    setState(() {
                      /* Update for `_collectingTask.inProgress` */
                    });
                  } else {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                      return SelectBondedDevicePage(checkAvailability: false);
                    }));

                    if (selectedDevice != null) {
                      await _startBackgroundTask(context, selectedDevice);
                      setState(() {
                        /* Update for `_collectingTask.inProgress` */
                      });
                    }
                  }
                },
              ),
            ),
            ListTile(
                title: RaisedButton(
              child: const Text('Exibir dados coletados em segundo plano'),
              onPressed: (_collectingTask != null)
                  ? () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ScopedModel<BackgroundCollectingTask>(
                          model: _collectingTask,
                          child: BackgroundCollectedPage(),
                        );
                      }));
                    }
                  : null,
            )),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ChatPage(server: server);
    }));
  }

  Future<void> _startBackgroundTask(
      BuildContext context, BluetoothDevice server) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask.start();
    } catch (ex) {
      if (_collectingTask != null) {
        _collectingTask.cancel();
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ocorreu um erro ao conectar'),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
