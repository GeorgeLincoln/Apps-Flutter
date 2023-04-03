import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/chatroom.dart';
import 'package:xlo_mobx/screens/messages/messages_screen.dart';
import 'package:xlo_mobx/stores/chat_room_store.dart';

class ChatRoomTile extends StatelessWidget {
  ChatRoomTile(this.chatRoom);

  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GetIt.I<ChatRoomStore>().setChatRoom(chatRoom);

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MessageScreen()));
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkImage(
                  imageUrl: chatRoom.ad.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : chatRoom.ad.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chatRoom.ad.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        chatRoom.ad.description,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        chatRoom.lastMessageText,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(chatRoom.lastDateTimeMessage
                        .toLocal()
                        .formattedMessageDate()),
                    if (chatRoom.ad.status.index > AdStatus.SOLD.index)
                      Text(
                        '${chatRoom.ad.status.description}',
                        textAlign: TextAlign.center,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
