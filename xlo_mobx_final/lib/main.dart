import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'screens/base/base_screen.dart';
import 'stores/category_store.dart';
import 'stores/chat_room_store.dart';
import 'stores/connectivity_store.dart';
import 'stores/favorite_store.dart';
import 'stores/home_store.dart';
import 'stores/location_store.dart';
import 'stores/page_store.dart';
import 'stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  await configOneSignal();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(ConnectivityStore());
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(LocationStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(HomeStore());
  GetIt.I.registerSingleton(CategoryStore());
  GetIt.I.registerSingleton(FavoriteStore());
  GetIt.I.registerSingleton(ChatRoomStore());
}

Future<void> configOneSignal() async {
  OneSignal.shared.setLogLevel(OSLogLevel.none, OSLogLevel.none);
  OneSignal.shared.setLocationShared(false);

  //CONFIGURA O ONESIGNAL DE ACORDO COM A CHAVE CRIADA NO ONESIGNAL
  OneSignal.shared.setAppId('1e6872fc-edd8-47b6-a894-97bc55ae423e');
}

Future<void> initializeParse() async {
  const appId = '8MmuFHBcTejklfFhxsvS03gy0XIijosSQp6l5Da8';
  const clientKey = 'Jbohcr47krRtH2YnPuusp5xLHvXYH7GNMSmcuRnA';
  const serverURL = 'https://parseapi.back4app.com/';
  const serverLiveQueryURL = 'https://xlo-mobx.b4a.io';

  await Parse().initialize(appId, serverURL,
      clientKey: clientKey,
      autoSendSessionId: true,
      debug: true,
      liveQueryUrl: serverLiveQueryURL);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.purple,
          appBarTheme: AppBarTheme(elevation: 0),
          textSelectionTheme:
              TextSelectionThemeData(cursorColor: Colors.orange)),
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: BaseScreen(),
    );
  }
}
