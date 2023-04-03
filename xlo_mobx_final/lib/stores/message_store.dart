import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/messages.dart';
import 'package:xlo_mobx/repositories/message_repository.dart';
import 'package:xlo_mobx/stores/chat_room_store.dart';

part 'message_store.g.dart';

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  final ChatRoomStore chatRoomStore = GetIt.I<ChatRoomStore>();
  final MessageRepository messageRepository = MessageRepository();

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  ObservableList<Message> messageList = ObservableList<Message>();

  @action
  getMessagesList() async {
    try {
      setLoading(true);
      final messages =
          await messageRepository.getMessagesList(chatRoomStore.chatRoom);
      messageList.clear();
      messageList.addAll(messages);
      setLoading(false);
    } catch (e) {
      print(e);
    }
  }

  @action
  liveMessageList() async {
    messageRepository.liveMessageList(
        chatRoom: chatRoomStore.chatRoom,
        onNewMessage: (Message message) {
          messageList.insert(0, message);
        });
  }

  @action
  sendMessage(String message) async {
    if (chatRoomStore.chatRoom == null) {
      final chatRoom = await chatRoomStore.createChatRoom(ad: chatRoomStore.ad);
      chatRoomStore.setChatRoom(chatRoom);
    } else {
      if (!chatRoomStore.chatRoomList
          .any((e) => e.id == chatRoomStore.chatRoom.id)) {
        setError('Chat foi excluído');
        return;
      }
    }

    messageRepository.saveMessage(
        users: chatRoomStore.users,
        chatRoom: chatRoomStore.chatRoom,
        textMessage: message,
        destination: chatRoomStore.destination);
  }

  cancelLive() {
    chatRoomStore.setChatRoom(null);
    chatRoomStore.setAd(null);
    messageRepository.cancelLiveQuery();
  }

  _MessageStore() {
    when((_) => chatRoomStore.chatRoom != null, () {
      if (!chatRoomStore.isNew) {
        getMessagesList();
      }
      liveMessageList();
    });
  }
}
