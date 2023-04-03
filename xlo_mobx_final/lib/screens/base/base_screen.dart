import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/ad/ad_screen.dart';
import 'package:xlo_mobx/screens/chat_room/chat_room_screen.dart';
import 'package:xlo_mobx/screens/create/create_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/screens/home/home_screen.dart';
import 'package:xlo_mobx/screens/location/location_screen.dart';
import 'package:xlo_mobx/screens/messages/messages_screen.dart';
import 'package:xlo_mobx/screens/offline/offline_screen.dart';
import 'package:xlo_mobx/stores/chat_room_store.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';
import 'package:xlo_mobx/stores/home_store.dart';
import 'package:xlo_mobx/stores/location_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();
  final LocationStore locationStore = GetIt.I<LocationStore>();

  bool showLocation = false;

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));

    when((_) => locationStore.showLocationScreen, () {
      Future.delayed(Duration(milliseconds: 50)).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => LocationScreen(
                  showInfoDialog: true,
                )));
      });
    });

    autorun((_) {
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          showDialog(context: context, builder: (_) => OfflineScreen());
        });
      }
    });

    oneSignalEvents();
  }

  void oneSignalEvents() async {
    //Quando a notificação é aberta pelo usuário
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      if (result.notification.additionalData.containsKey('adId')) {
        final ad = await HomeStore()
            .getAdById(result.notification.additionalData['adId']);
        if (ad != null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AdScreen(ad)));
        }
      }

      if (result.notification.additionalData.containsKey('chatRoomId')) {
        final chatRoom = GetIt.I<ChatRoomStore>().chatRoomList.firstWhere(
            (c) => c.id == result.notification.additionalData['chatRoomId']);

        if (chatRoom != null) {
          GetIt.I<ChatRoomStore>().setChatRoom(chatRoom);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => MessageScreen()));
        }
      }
    });

    //Decide se a notificação de ser exibida ou não
    //Se a tela de Messages do chat estiver aberta, não exibe notificações sobre ela
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      if (event.notification.additionalData.containsKey('chatRoomId')) {
        if (GetIt.I<ChatRoomStore>().chatRoom != null &&
            event.notification.additionalData['chatRoomId'] ==
                GetIt.I<ChatRoomStore>().chatRoom.id) {
          event.complete(null);
        } else {
          event.complete(event.notification);
        }
      } else {
        event.complete(event.notification);
      }
    });
    await OneSignal.shared.promptUserForPushNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          ChatRoomScreen(),
          FavoritesScreen(),
          AccountScreen(),
        ],
      ),
    );
  }
}
