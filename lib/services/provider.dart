
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:halo/services/firestore_service.dart';


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangeProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final databaseProvider = Provider<FireStoreService?>((ref) {
  final auth = ref.watch(authStateChangeProvider);
  String? uid = auth.asData?.value?.uid;
  if(uid != null) {
    return FireStoreService(uid: uid);
  }
  return FireStoreService(uid: uid ?? "");
});

final nameProvider = ChangeNotifierProvider<NameText>((ref) => NameText());

class NameText extends ChangeNotifier {
  String name = "";
  setName(String n) {
    name = n;
    notifyListeners();
  }
}