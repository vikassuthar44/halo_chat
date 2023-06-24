import 'package:flutter/material.dart';
import 'package:halo/pages/select_person_to_chat_page.dart';

import 'colors.dart';
import 'custom_text.dart';

class CustomSmallAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;

  CustomSmallAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      title: TitleText(
        title,
        context
      ),
      centerTitle: false,
      backgroundColor: ColorClass.background,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {

          },
          child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(
                  Icons.person,
                color: Theme.of(context).colorScheme.primary,
              )
          ),
        ),
      ),
      actions:  [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => SelectPersonToChat(isAppbar: false)));
            },
            icon: Icon(
                Icons.contacts
            )
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(10, 50);
}
