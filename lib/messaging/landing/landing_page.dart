import 'package:flutter/material.dart';
import 'package:halo/messaging/home/home_page.dart';

import '../../util/custom_button.dart';
import '../login/login_page.dart';
import 'custom_cricle.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's \nGet Started",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 45, fontWeight: FontWeight.w900),
                ),
                Text(
                  "Connect with each other with chatting or calling. Enjoy safe and private texting.",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (isLoading) return;
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(milliseconds: 200));
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => LoginPage()));
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: CustomButton(
                      size: size.width * 0.9,
                      text: "Let's Start",
                      isLoading: isLoading,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 10.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
