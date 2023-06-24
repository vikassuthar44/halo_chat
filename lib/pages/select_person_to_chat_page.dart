import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/messaging/chatdetails/chat_details.dart';
import 'package:halo/models/chat.dart';
import 'package:halo/models/user_data.dart';
import 'package:halo/services/provider.dart';
import 'package:halo/util/custom_text.dart';

import '../util/colors.dart';

@immutable
class SelectPersonToChat extends ConsumerWidget {
  bool isAppbar;

  SelectPersonToChat({required this.isAppbar, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingController = TextEditingController();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: ColorClass.background,
          centerTitle: false,
          title: isAppbar == false
              ? TitleText("Select Person to chat", context)
              : Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextField(
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        hintText: "search user or friends...",
                        label: Text(
                          "Search user",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius: BorderRadius.circular(15)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        labelStyle: Theme.of(context).textTheme.titleSmall,
                      ),
                      keyboardType: TextInputType.phone,
                      controller: editingController),
                ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<UserData>>(
          stream: ref.read(databaseProvider)?.getUsers(),
          builder: (context, snashot) {
            if (snashot.hasError) {
              return const Center(
                child: Text("Went sometinhg wrong!"),
              );
            }
            if (snashot.hasData == false) {
              return const Center(
                child: Text("No user found..."),
              );
            }
            final users = snashot.data ?? [];
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final myUser = ref.read(firebaseAuthProvider).currentUser!;
                  if (user.uid == myUser.uid) {
                    return Container();
                  }
                  return GestureDetector(
                    onTap: () async {
                      final chatId = await ref
                          .read(databaseProvider)
                          ?.getChatStarted(myUser.uid, user.uid) ??
                          false;
                      if (chatId == "") {
                        await ref
                            .read(databaseProvider)
                            ?.startChat(
                            myUser.uid, user.uid, user.name, "", "")
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatDetails(
                                      chat: Chat(
                                          chatId: value,
                                          myUid: myUser.uid,
                                          otherUid: user.uid,
                                          myName: "",
                                          otherName: user.name,
                                          lastMsg: "",
                                          lastMsgTime: ""))));
                        });
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatDetails(
                                    chat: Chat(
                                        chatId: chatId.toString(),
                                        myUid: myUser.uid,
                                        otherUid: user.uid,
                                        myName: "",
                                        otherName: user.name,
                                        lastMsg: "",
                                        lastMsgTime: ""))));
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.secondary,
                                      child: const Icon(Icons.person),
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                          ),
                        ),
                        //const Divider()
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
