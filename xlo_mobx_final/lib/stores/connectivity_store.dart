import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mobx/mobx.dart';

part 'connectivity_store.g.dart';

class ConnectivityStore = _ConnectivityStore with _$ConnectivityStore;

abstract class _ConnectivityStore with Store {
  _ConnectivityStore() {
    _setupListener();
  }

  void _setupListener() {
    DataConnectionChecker().checkInterval = Duration(seconds: 5);
    DataConnectionChecker().onStatusChange.listen((event) {
      setConnected(event == DataConnectionStatus.connected);
    });
  }

  @observable
  bool connected = true;

  @action
  void setConnected(bool value) => connected = value;
}
