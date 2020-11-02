import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  LoginViewModel() {
    Firebase.initializeApp();
  }
  GoogleSignIn googleSignIn = GoogleSignIn();
  String logoUrl = "lib/assets/logo/flutter-logo.png";

  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final User user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user != null ? true : false;
  }
}
