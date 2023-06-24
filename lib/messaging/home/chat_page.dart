import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/messaging/chatdetails/chat_details.dart';
import 'package:halo/models/chat.dart';
import 'package:halo/services/provider.dart';

class ChatUser {
  late String name = "";
  late String lastMessage = "";
  late String lastMessageTime = "";
  late int unreadMsgCount = 0;
  late bool isUnread = false;

  ChatUser(this.name, this.lastMessage, this.lastMessageTime,
      this.unreadMsgCount, this.isUnread);
}

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    Stream<List<Chat?>>? stream = ref.read(databaseProvider)?.getChats();
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Container();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            /*if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }*/
            final chats = snapshot.data ?? [];
            return ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final myUser = ref.read(firebaseAuthProvider).currentUser;
                  if (chat == null) {
                    return Container();
                  }
                  return Column(
                    children: [
                      singleUser(chat, myUser)
                      /* ListTile(
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetails(chat: chat)));
                      },
                      title: Text(myUser?.uid == chat.myUid ? chat.otherName : chat.myName),
                    )*/
                    ],
                  );
                });
          }
        });
    /*Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: widget.chatUser.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return singleUser(widget.chatUser[index]);
          }),
    );*/
  }

  Widget singleUser(Chat chatUser, User? myUser) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatDetails(
                        chat: chatUser,
                      )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(Icons.person),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatUser.otherName
                      /*myUser?.uid == chatUser.myUid
                          ? chatUser.otherName
                          : chatUser.myName*/
                      ,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Text(
                                chatUser.lastMsg,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: false == true
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : null),
                              ),
                            ),
                            Text(
                              chatUser.lastMsgTime.substring(0,19),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: false == true
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : null),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            /*if (false)
              CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                  child: Text(chatUser.unreadMsgCount.toString()))*/
          ],
        ),
      ),
    );
  }
}
