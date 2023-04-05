import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/messages.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class MessageTile extends StatelessWidget {
  MessageTile(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: isDestination() ? Alignment.topLeft : Alignment.topRight,
        child: Column(
          crossAxisAlignment: isDestination()
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDestination() ? Colors.orange : Colors.purple),
              padding: EdgeInsets.all(16),
              child: Text(
                message.text,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message.sendDate.toLocal().formattedMessageDate()),
            )
          ],
        ),
      ),
    );
  }

  bool isDestination() =>
      GetIt.I<UserManagerStore>().user.id == message.destinationId;
}
