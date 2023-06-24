import 'package:flutter/material.dart';
import 'package:halo/account/account_class.dart';
import 'package:halo/messaging/home/chat_page.dart';
import 'package:halo/messaging/home/setting_page.dart';
import 'package:halo/pages/select_person_to_chat_page.dart';
import 'package:halo/shared_preference/shared_preference.dart';

import '../../util/small_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String userName = "";
  var currentSelectedPage = 0;
  final pages = [
    const ChatPage(),
    SelectPersonToChat(isAppbar: true),
    //const CallPage(),
    SettingPage(),
    AccountClass(isAppbar:false)
  ];

  List<IconData> bottomItem = [
    Icons.home,
    Icons.search,
    //Icons.call,
    Icons.settings,
    Icons.person
  ];

  void updatePage(int index) {
    setState(() {
      currentSelectedPage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  void getUserName() async {
    String getUserName = await SharedPreference.getUserName();
    setState(() {
      userName = getUserName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomSmallAppBar(title: userName),
      body: pages[currentSelectedPage],
      bottomNavigationBar: haloBottomBar(),
    );
  }

  Widget haloBottomBar() {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.primary.withAlpha(60),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 5,
              )
            ],
          ),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemExtent: (MediaQuery.of(context).size.width-40)/4,
              itemCount: bottomItem.length,
              itemBuilder: (context, index) {
                return BottomBarIcon(bottomItem[index], index == currentSelectedPage, index);
              })
      ),
    );
  }

  Widget BottomBarIcon(IconData iconData, bool selected, int index) {
    List<Color> colors = [Theme.of(context).colorScheme.secondary.withOpacity(0.4), Colors.transparent];
    return Container(
      decoration: selected == true ? BoxDecoration(
        gradient: RadialGradient(
            colors: colors
        ),) : null,
      child: IconButton(
          onPressed: () {
            setState(() {
              currentSelectedPage = index;
            });
          },
          icon: Icon(iconData,
              size: 35,
              color: selected == true
                  ? Theme.of(context).colorScheme.primary
                  : null)),
    );
  }
}
