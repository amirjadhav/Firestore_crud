import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

bool isLoggedIn() {
  return FirebaseAuth.instance.currentUser != null ? true : false;
}
