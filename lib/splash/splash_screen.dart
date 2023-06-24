import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/messaging/home/home_page.dart';
import 'package:halo/messaging/landing/landing_page.dart';
import 'package:halo/shared_preference/shared_preference.dart';

import '../messaging/landing/custom_cricle.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool moveToNext = true;
  bool isLogged = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedIn();
  }

  void getUserLoggedIn() async {
    bool isUserLogged = await SharedPreference.getLoggedIn();
    await Future.delayed(const Duration(seconds:2));
    setState(() {
      moveToNext = false;
      isLogged = isUserLogged;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(moveToNext) {
      return Container(
        color: Theme.of(context).colorScheme.onSurface,
        child: Stack(
          children: [
            Positioned(
              right: 120,
              top: -20,
              child: CustomCircle(color: Theme.of(context).colorScheme.primary),
            ),
            Positioned(
              left: 120,
              top: 220,
              child: CustomCircle(color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      );
      
    } else {
      if(isLogged) {
        return const HomePage();
      } else {
        return const LandingPage();
      }
    }
  }
}