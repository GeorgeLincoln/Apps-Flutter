import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/dialog_platform.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/messages/components/text_message.dart';
import 'package:xlo_mobx/stores/chat_room_store.dart';
import 'package:xlo_mobx/stores/message_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import 'components/ad_tile_message.dart';
import 'components/message_tile.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen();

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final user = GetIt.I<UserManagerStore>().user;

  final ScrollController listScrollController = ScrollController();

  final MessageStore messageStore = MessageStore();
  final ChatRoomStore chatRoomStore = GetIt.I<ChatRoomStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => messageStore.messageList, (m) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (listScrollController.hasClients) {
          listScrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(chatRoomStore.ad.title), //Text(ad.title),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext bc) => [
                PopupMenuItem(child: Text("Ver perfil"), value: 0),
                PopupMenuItem(child: Text("Excluir "), value: 1),
              ],
              onSelected: (choice) {
                if (choice == 0) {
                  showProfile(context);
                } else {
                  deleteChatRoom(context);
                }
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AdTileMessage(chatRoomStore.ad),
            Expanded(
              child: GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(new FocusNode()),
                  child: Observer(
                    builder: (_) {
                      return ListView.builder(
                          shrinkWrap: true,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          controller: listScrollController,
                          reverse: true,
                          itemCount: messageStore.messageList.length,
                          itemBuilder: (_, index) {
                            return MessageTile(messageStore.messageList[index]);
                          });
                    },
                  )),
            ),
            if (chatRoomStore.ad.status == AdStatus.ACTIVE)
              Observer(
                builder: (_) {
                  if (messageStore.error != null) {
                    return Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                Center(
                                    child: Text(
                                  messageStore.error,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                )),
                                SizedBox(
                                  height: 16,
                                ),
                              ],
                            )));
                  } else {
                    return TextMessage(messageStore: messageStore);
                  }
                },
              ),
            if (chatRoomStore.ad.status.index >= AdStatus.SOLD.index)
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Icon(Icons.dangerous),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                        child: Text(
                      'Não é possível continuar esta conversa porque o anúncio não está mais ativo',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )),
                    SizedBox(height: 8),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  void deleteChatRoom(BuildContext context) {
    if (chatRoomStore.chatRoom == null) return;

    showDialog(
        context: context,
        builder: (_) => DialogPlatform(
              title: 'Excluir',
              content:
                  'Confirma exclusão do Chat \'${chatRoomStore.ad.title}\'?',
              textNoButton: 'Não',
              textYesButton: 'Sim',
              actionNo: () => Navigator.of(context).pop(),
              actionYes: () async {
                chatRoomStore.deleteChatRom(chatRoomStore.chatRoom);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ));
  }

  void showProfile(BuildContext context) {
    final user = chatRoomStore.destination;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
            height: 250,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Na XLO desde ${user.createdAt.formattedDate()}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    user.type.index == 0 ? 'Particular' : 'Profissional',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 8,
                        ),
                        Center(child: Text(user.phone)),
                      ],
                    ))
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    messageStore.cancelLive();
    super.dispose();
  }
}
