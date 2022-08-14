import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsbuzz/provider/login.dart';
import 'package:newsbuzz/screens/home.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    LoginProvider loginFormState = context.watch<LoginProvider>();
    var formKey = loginFormState.formKey;
    TextEditingController emailController = loginFormState.emailController,
        passwordController = loginFormState.passwordController;
    bool isLoginForm = loginFormState.isLoginForm;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (isLoginForm) ? "LogIn" : "SignIn",
                style: GoogleFonts.eczar(
                  fontSize: 40,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                Provider.of<LoginProvider>(context, listen: false).errorMsg ??
                    '',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Username",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person))),
              const SizedBox(height: 30),
              TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the password';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: "Password",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.security))),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  bool isValidated = formKey.currentState!.validate();

                  if (isValidated) {
                    if (isLoginForm) {
                      Provider.of<LoginProvider>(context, listen: false)
                          .logIn();
                    } else {
                      Provider.of<LoginProvider>(context, listen: false).signIn(
                          emailController.text, passwordController.text);
                    }
                  }
                },
                child: Text((isLoginForm) ? "LogIn" : "SignIn"),
              ),
              InkWell(
                onTap: context.read<LoginProvider>().toogleForm,
                child: Text(
                  (isLoginForm)
                      ? "Don't have an account SignIn"
                      : "Already have an account LogIn",
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen())),
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Center(
                    child: Text(
                      "Continue as guest",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
