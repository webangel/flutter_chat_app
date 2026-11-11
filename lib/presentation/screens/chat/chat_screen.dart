import 'package:flutter/material.dart';
import 'package:flutter_chat_app/config/helpers/get_yes_no_answer.dart';
import 'package:flutter_chat_app/config/theme/app_theme.dart';
import 'package:flutter_chat_app/domain/entities/message.dart';
import 'package:flutter_chat_app/presentation/providers/chat_provider.dart';
import 'package:flutter_chat_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:flutter_chat_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:flutter_chat_app/presentation/widgets/shared/message_field_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.title, this.selectedColor = 0});

  final String title;
  final int selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme(
          selectedColor: selectedColor,
        ).theme().colorScheme.inversePrimary,
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://instagram.flim28-2.fna.fbcdn.net/v/t51.82787-15/620812612_18068073452195140_9112004015657812432_n.jpg?stp=dst-jpg_e35_tt6&_nc_cat=104&_nc_map=urlgen_bucketless&ig_cache_key=MjU4MjM0Njg4MjI1MzA1NjE3Mw%3D%3D.3-ccb7-5&ccb=7-5&_nc_sid=58cdad&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQueHBpZHMuNzIwLnNkci5yZWd1bGFyX3Bob3RvLkMzIn0%3D&_nc_ohc=nhUP4NlNnDwQ7kNvwGmhLnI&_nc_oc=Adqhw8gK1aJexYmBIU8d5BL6QTapP5bblFsTlMWCDxy4GfmTrLixgothPI82kQFR8qI&_nc_zt=23&_nc_ht=instagram.flim28-2.fna&_nc_gid=xpMhSeJMrv88jmhBlocjRQ&_nc_ss=7baaf&oh=00_AQSLcsTJLPfZ3Ig0pw8uDR2G17DqU0Q4uBLrOR5ynv14ZA&oe=6AF428C7',
            ),
          ),
        ),
        title: Text(title),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messagesList.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messagesList[index];

                  return (message.fromWho == FromWho.me)
                      ? MyMessageBubble(message: message)
                      : HerMessageBubble(message: message);
                },
              ),
            ),

            /// Caja de texto de mensajes
            MessageFieldBox(
              onValue: (value) {
                chatProvider.sendMessage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
