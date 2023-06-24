import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/services/provider.dart';
import 'package:halo/shared_preference/shared_preference.dart';
import 'package:halo/util/custom_text.dart';

import '../util/colors.dart';

class AccountClass extends ConsumerStatefulWidget {
  bool isAppbar = true;
  AccountClass({required this.isAppbar, super.key});

  @override
  ConsumerState<AccountClass> createState() => _AccountClassState();
}

class _AccountClassState extends ConsumerState<AccountClass> {
  String userName = "", phoneNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
  }

  void getUserName() async {
    String getUserName = await SharedPreference.getUserName();
    String getPhoneNumber = await SharedPreference.getPhoneNumber();
    setState(() {
      userName = getUserName;
      phoneNumber = getPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppbar == true ? AppBar(
        shadowColor: Colors.transparent,
        title: TitleText("Profile", context),
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
      ) : AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 40, color: Colors.white,),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        color: Colors.grey),
                    child: const Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 10,
                  ),
                  Text(
                    "Edit",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.blue),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(color: Colors.white, height: 20),
                Container(
                  color: Colors.black12,
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Container(
                    color: ColorClass.background,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "User Name",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: TitleText(userName, context),
                ),
              ],
            ),
            Container(
              color: Colors.black12,
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                color: ColorClass.background,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Phone Number",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: TitleText(phoneNumber, context),
            ),

          ],
        ),
      ),
    );
  }
}
