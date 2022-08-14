import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginProvider with ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isloggedIn = false;
  bool isLoginForm = true;
  String? errorMsg;

  LoginProvider() {
    FirebaseAuth.instance.userChanges().listen(
      (User? user) {
        (user == null) ? isloggedIn = false : isloggedIn = true;
        notifyListeners();
      },
    );
  }

  void setErrorMessage(String? msg) {
    errorMsg = msg;
    notifyListeners();
  }

  void toogleForm() {
    isLoginForm = !isLoginForm;
    notifyListeners();
  }

  void clearInputForm() {
    emailController.text = "";
    passwordController.text = "";
    errorMsg = "";
    notifyListeners();
  }

  void signIn(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setErrorMessage('The account already exists for that email.');
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
  }

  void logIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("NO user found");
        setErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print("wrong password");
        setErrorMessage("Wrong password");
      } else {
        setErrorMessage("An unexpected error occured");
      }
    }
    if (isloggedIn) {
      clearInputForm();
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
