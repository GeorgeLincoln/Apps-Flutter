import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/stores/chat_room_store.dart';

import 'components/chatroom_tile.dart';

class ChatRoomScreen extends StatelessWidget {
  final ChatRoomStore chatRoomStore = GetIt.I<ChatRoomStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Chat'),
              centerTitle: true,
            ),
            drawer: CustomDrawer(),
            body: Observer(builder: (_) {
              if (chatRoomStore.chatRoomList.isEmpty)
                return EmptyCard('Você não tem chats ativos');

              return ListView.builder(
                  padding: const EdgeInsets.all(2),
                  itemCount: chatRoomStore.chatRoomList.length,
                  itemBuilder: (_, index) =>
                      ChatRoomTile(chatRoomStore.chatRoomList[index]));
            })));
  }
}
