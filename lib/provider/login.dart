import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider with ChangeNotifier {
  bool isloggedIn = false;
  bool isLoginForm = true;

  LoginProvider() {
    FirebaseAuth.instance.userChanges().listen(
      (User? user) {
        (user == null) ? isloggedIn = false : isloggedIn = true;
        notifyListeners();
      },
    );
  }
  void toogleForm() {
    isLoginForm = !isLoginForm;
    notifyListeners();
  }

  void signIn(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // print("CREDENTIALS  $credential");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void logIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
