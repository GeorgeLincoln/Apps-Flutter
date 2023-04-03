import 'package:flutter/material.dart';
import 'package:xlo_mobx/stores/message_store.dart';

class TextMessage extends StatefulWidget {
  final MessageStore messageStore;
  TextMessage({@required this.messageStore});

  @override
  _TextMessageState createState() => _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  final TextEditingController controller = TextEditingController();
  bool isComposing = false;

  void reset() {
    controller.clear();
    setState(() {
      isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 8,
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                        hintText: 'Digite uma mensagem....'),
                    onChanged: (text) {
                      setState(() {
                        isComposing = text.trim().isNotEmpty;
                      });
                    },
                    onSubmitted: (text) {
                      widget.messageStore.sendMessage(controller.text);
                      reset();
                    },
                  )),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: isComposing
                    ? () {
                        //widget.sendMessage(text: _controller.text);
                        widget.messageStore.sendMessage(controller.text);
                        reset();
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
