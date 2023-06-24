import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/models/chat.dart';
import 'package:halo/models/message.dart';
import 'package:halo/services/provider.dart';

import '../../util/colors.dart';
import '../../util/custom_text.dart';


class MessageData {
  String message;
  bool isSend;
  String time;

  MessageData(this.message, this.isSend, this.time);
}

class ChatDetails extends ConsumerStatefulWidget {
  static const opacityCurve = Interval(0.0, 0.75, curve: Curves.fastOutSlowIn);
  final Chat chat;
  const ChatDetails({required this.chat, Key? key}) : super(key: key);

  @override
  ConsumerState<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends ConsumerState<ChatDetails> with SingleTickerProviderStateMixin {
  final _textMessageController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final myUid = ref.read(firebaseAuthProvider).currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: TitleText(widget.chat.myUid == myUid ? widget.chat.otherName : widget.chat.myName, context),
        centerTitle: false,
        backgroundColor: ColorClass.background,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          //IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_sharp))
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/chat_bg.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Expanded(
                    child: StreamBuilder<List<Message>>(
                      stream: ref.read(databaseProvider)?.getMessages(widget.chat.chatId),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.active && snapshot.hasData){
                          final messages = snapshot.data ?? [];
                          return ListView.builder(
                            reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (_, index) {
                              final message = messages[index];
                              final isMe = message.myUid == ref.read(firebaseAuthProvider).currentUser?.uid;
                              if(isMe) {
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: myChatBubble(message),
                                );
                              } else {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: otherChatBubble(message),
                                );
                              }
                              }
                          );
                        }
                        return Container();
                      },
                    )
                ),
                _sendMessageTextField(widget.chat.chatId),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myChatBubble(Message message) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin:
      const EdgeInsets.only(left: 50.0, right: 15.0, top: 7.0, bottom: 7.0),
      decoration: BoxDecoration(
        color: const Color(0xffE2FDC4),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(.1),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Text(message.text),
    );
  }

  Widget otherChatBubble(Message message) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin:
      const EdgeInsets.only(left: 15.0, right: 50.0, top: 7.0, bottom: 7.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.grey.withOpacity(.1),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Text(message.text),
    );
  }

  Widget _sendMessageTextField(String chatId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 4, right: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.2),
                        offset: const Offset(0.0, 0.50),
                        spreadRadius: 1,
                        blurRadius: 1),
                  ]),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 60,
                      ),
                      child: Scrollbar(
                        child: TextField(
                          maxLines: null,
                          style: const TextStyle(fontSize: 14),
                          controller: _textMessageController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.link),
                      const SizedBox(
                        width: 10,
                      ),
                      _textMessageController.text.isEmpty
                          ? const Icon(Icons.camera_alt)
                          : const Text(""),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () async {
              if (_textMessageController.text.isNotEmpty) {
                print("'message sent'");
                await ref.read(databaseProvider)?.sendMessage(
                    widget.chat.chatId,
                    Message(
                        text: _textMessageController.text.trim(),
                        myUid: ref.read(firebaseAuthProvider).currentUser?.uid,
                        time: DateTime.now().toString()));
                await ref.read(databaseProvider)?.updateLasMsg(_textMessageController.text.trim(), DateTime.now().toString(), chatId);
                // _sendTextMessage();
                _textMessageController.text = "";
              }
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget singleMessage(MessageData message) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: message.isSend == true
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Align(
              alignment: message.isSend == true
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: message.isSend == true
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: message.isSend == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: message.isSend == true
                        ? const EdgeInsets.only(left: 40)
                        : const EdgeInsets.only(right: 40),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: message.isSend == true
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))
                            : BorderRadius.circular(10)),
                    child: Text(
                      message.message,
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message.time,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
