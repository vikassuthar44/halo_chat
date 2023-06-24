import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/firebase_options.dart';
import 'package:halo/services/provider.dart';
import 'package:halo/util/theme.dart';
import 'package:halo/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(child: MyApp()));
  //runApp(const MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    //need to calls bcz first time didn't load data
    ref.read(databaseProvider)?.getChats();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: haloTheme(context, false),
      home: const SplashScreen(),
    );
  }
}