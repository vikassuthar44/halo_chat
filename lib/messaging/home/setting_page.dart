import 'package:flutter/material.dart';
import 'package:halo/account/account_class.dart';
import 'package:halo/shared_preference/shared_preference.dart';

import '../../starredmessage/starred_message.dart';

class SettingDetails {
  String title;
  IconData iconData;

  SettingDetails(this.title, this.iconData);
}

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<SettingDetails> settingDetails = [
    SettingDetails("Account", Icons.key),
    SettingDetails("Privacy", Icons.lock),
    SettingDetails("Notifications", Icons.notifications),
    SettingDetails("Share", Icons.share),
    SettingDetails("Help", Icons.help),
  ];

  late String userName = "";

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
    return ListView(
      children: [
        profileWidget(),
        singleSettingDetails(settingDetails[0], 0),
        singleSettingDetails(settingDetails[1], 1),
        singleSettingDetails(settingDetails[2], 2),
        singleSettingDetails(settingDetails[3], 3),
        singleSettingDetails(settingDetails[4], 4),
      ],
    );
  }

  Widget singleSettingDetails(SettingDetails settingDetails, int index) {
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            {
              //open account screen
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AccountClass(isAppbar: true);
              }));
              break;
            }
          case 1:
            {
              //privacy screen
              break;
            }
          case 2:
            {
              //open started message screen
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const StarredMessage();
              }));
              break;
            }
          case 3:
            {
              // open notification screen
              break;
            }
          case 4:
            {
              //open share dialog
              break;
            }
          case 5:
            {
              //open help screen
              break;
            }
        }
        print("dsvsdav");
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(settingDetails.iconData),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(settingDetails.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          )),
    );
  }

  Widget profileWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: const Icon(Icons.person),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text("This is simple text...",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          )
        ],
      ),
    );
  }
}
