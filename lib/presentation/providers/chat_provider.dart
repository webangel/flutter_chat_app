import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/helpers/get_yes_no_answer.dart';
import 'package:flutter_chat_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  int _selectedColor = 0;

  int get selectedColor => _selectedColor;

  void setSelectedColor(int color) {
    _selectedColor = color;
    notifyListeners();
  }

  final chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messagesList = [
    Message(text: 'Hola amor!!', fromWho: FromWho.me),
    Message(text: 'Ya regersaste del trabajo?', fromWho: FromWho.me),
  ];

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messagesList.add(newMessage);

    if (text.endsWith('?')) {
      herReply();
    }

    notifyListeners();
    moveScrollToBottom();

    await Future.delayed(const Duration(milliseconds: 500));

    // final herMessage = Message(
    //   text: 'Hola amor, estoy en el trabajo, te extraño mucho 😢',
    //   fromWho: FromWho.hers,
    // );
    // messagesList.add(herMessage);
    // notifyListeners();
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messagesList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
