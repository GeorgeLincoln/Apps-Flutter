import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/messages/messages_screen.dart';
import 'package:xlo_mobx/stores/chat_room_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class BottomBar extends StatelessWidget {
  BottomBar(this.ad);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    if (ad.status == AdStatus.PENDING ||
        ad.user.id == GetIt.I<UserManagerStore>().user.id) return Container();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: Colors.orange,
            ),
            child: Row(
              children: [
                if (!ad.hidePhone)
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final phone =
                            ad.user.phone.replaceAll(RegExp('[^0-9]'), '');

                        if (await canLaunch(phone)) {
                          launch('tel:$phone');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Falha ao iniciar ligação'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                              },
                            ),
                          ));
                        }
                      },
                      child: Container(
                        height: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.black45),
                          ),
                        ),
                        child: Text(
                          'Ligar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      GetIt.I<ChatRoomStore>().setAd(ad);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MessageScreen()));
                    },
                    child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      child: Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(249, 249, 249, 1),
              border: Border(
                top: BorderSide(
                  color: Colors.grey[400],
                ),
              ),
            ),
            height: 38,
            alignment: Alignment.center,
            child: Text(
              '${ad.user.name} (anunciante)',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
