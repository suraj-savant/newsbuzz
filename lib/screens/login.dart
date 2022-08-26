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
  @override
  Widget build(BuildContext context) {
    LoginProvider loginFormState = context.watch<LoginProvider>();
    var formKey = loginFormState.formKey;
    TextEditingController emailController = loginFormState.emailController,
        passwordController = loginFormState.passwordController;
    bool isLoginForm = loginFormState.isLoginForm;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 600) {
              return mobileLoginWid(
                  isLoginForm, formKey, emailController, passwordController);
            } else {
              return webLoginWid(
                  isLoginForm, formKey, emailController, passwordController);
            }
          },
        )),
      ),
    );
  }

  Widget webLoginWid(
      bool isLoginForm,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginHeaderCard(
                isLoginForm: isLoginForm,
              ),
              LoginForm(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  isLoginForm: isLoginForm),
            ],
          ),
        ],
      ),
    );
  }

  Widget mobileLoginWid(
      bool isLoginForm,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoginHeaderCard(
          isLoginForm: isLoginForm,
        ),
        LoginForm(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
            isLoginForm: isLoginForm),
      ],
    );
  }
}

class LoginHeaderCard extends StatelessWidget {
  const LoginHeaderCard({Key? key, required this.isLoginForm})
      : super(key: key);
  final bool isLoginForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        Text(
          (isLoginForm) ? "LogIn" : "SignIn",
          style: GoogleFonts.eczar(
            fontSize: 40,
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset("assets/login.png"),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoginForm,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoginForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: 400,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Provider.of<LoginProvider>(context, listen: false).errorMsg ?? '',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormField(
                controller: emailController,
                validator: (value) {
                  value = value ?? "".trim();
                  if (value.isEmpty) {
                    return 'Please enter valid email';
                  } else if (!value.contains("@") || !value.contains(".com")) {
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
                  const passwordRegExp =
                      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
                  value = value ?? "".trim();
                  if (value.isEmpty) {
                    return 'Please enter the password';
                  } else if (!(value.length >= 8)) {
                    return "Password length mush be 8 digits";
                  } else if (!value.contains(RegExp(passwordRegExp))) {
                    return "Password must contains uppercase, lowercase letters.\nA number and aspecial character";
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
                    Provider.of<LoginProvider>(context, listen: false).logIn();
                  } else {
                    Provider.of<LoginProvider>(context, listen: false)
                        .signIn(emailController.text, passwordController.text);
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
          ],
        ),
      ),
    );
  }
}
