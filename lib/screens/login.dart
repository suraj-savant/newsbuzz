import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsbuzz/provider/login.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isLogInForm = context.watch<LoginProvider>().isLoginForm;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (isLogInForm) ? "LogIn" : "SignIn",
                style: GoogleFonts.eczar(
                  fontSize: 40,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
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
              const SizedBox(height: 20),
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
              ElevatedButton(
                onPressed: () {
                  bool isValidated = _formKey.currentState!.validate();

                  if (isValidated) {
                    if (isLogInForm) {
                      Provider.of<LoginProvider>(context, listen: false)
                          .logIn(emailController.text, passwordController.text);
                    } else {
                      Provider.of<LoginProvider>(context, listen: false).signIn(
                          emailController.text, passwordController.text);
                    }
                  }
                  // setState(() {
                  //   emailController.text = "";
                  //   passwordController.text = "";
                  // });
                },
                child: Text((isLogInForm) ? "LogIn" : "SignIn"),
              ),
              InkWell(
                onTap: context.read<LoginProvider>().toogleForm,
                child: Text(
                  (isLogInForm)
                      ? "Don't have an account SignIn"
                      : "Already have an account LogIn",
                  style: const TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
