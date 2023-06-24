import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../util/colors.dart';
import '../util/custom_text.dart';

class StarredMessageData {
  String message;
  String date;
  String time;
  StarredMessageData({required this.message, required this.date, required this.time});
}
class StarredMessage extends ConsumerStatefulWidget {
  const StarredMessage({super.key});

  @override
  ConsumerState<StarredMessage> createState() => _StarredMessageState();
}

class _StarredMessageState extends ConsumerState<StarredMessage> {

  List<StarredMessageData> messageList = List.generate(50, (index) => StarredMessageData(message: "This is message starred", date: "2 April 2023", time: "10:00 PM"));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: TitleText("Starred Message", context),
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
      ),
    );
  }

   Widget SingleStarredMessage() {
    return Container();
  }
}
