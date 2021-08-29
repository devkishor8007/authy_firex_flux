import 'package:authy_firex_flux/auth_service.dart';
import 'package:authy_firex_flux/main.dart';
import 'package:authy_firex_flux/screen_type/auth_screen/reset_screen.dart';
import 'package:authy_firex_flux/screen_type/auth_screen/signup_screen.dart';
import 'package:authy_firex_flux/widget/error_call_widget.dart';
import 'package:authy_firex_flux/widget/makeElevatedButton_widget.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:authy_firex_flux/widget/makeTextbutton_widget.dart';
import 'package:authy_firex_flux/widget/route_pass_widget.dart';
import 'package:authy_firex_flux/widget/textFormField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = true;
  late TextEditingController _email;
  late TextEditingController _pass;

  late FocusNode femail;
  late FocusNode fpass;

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    femail = FocusNode();
    fpass = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    femail.dispose();
    fpass.dispose();
  }

  final GlobalKey<FormState> _globalLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.09,
              left: size.width * 0.02,
              right: size.width * 0.02,
            ),
            child: Form(
              key: _globalLoginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  makeText(
                    "FirexFlux",
                    fontWeight: FontWeight.bold,
                    size: Theme.of(context).textTheme.headline5!.fontSize,
                  ),
                  SizedBox(
                    height: size.height * 0.2,
                  ),
                  makeText(
                    "Log In",
                    fontWeight: FontWeight.bold,
                    textColor: Colors.grey,
                    size: Theme.of(context).textTheme.headline6!.fontSize,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  makeTextField(
                    autofocus: true,
                    controller: _email,
                    hintText: "Enter your Email",
                    obscureText: false,
                    focusNode: femail,
                    onFieldSubmitted: (next) {
                      femail.unfocus();
                      FocusScope.of(context).requestFocus(fpass);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val!.isEmpty || !val.contains("@gmail.com"))
                        return "Enter your valid email where contain @gmail.com";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  makeTextField(
                    autofocus: true,
                    controller: _pass,
                    hintText: "Enter your Password",
                    obscureText: _showPassword,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(_showPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    focusNode: fpass,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.isEmpty) return "Please add your password!";
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: makeTextButton('Forgot Password', onPressed: () {
                      push(context, ResetPassword());
                    }),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  makeElevatedButton(
                    context,
                    "Login",
                    textSize: Theme.of(context).textTheme.button!.fontSize,
                    onPressed: () async {
                      final valid = _globalLoginKey.currentState!.validate();
                      if (valid) {
                        try {
                          final res = await AuthServices.loginwithEmail(
                            email: _email.text.trim().toUpperCase(),
                            password: _pass.text.trim(),
                          );
                          if (res != null) {
                            print("Welcome to account!");
                            pushReplacement(context, FirebaseAuthChecker());
                          } else {
                            print("getting error signup");
                            errorMessage(context, size);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'wrong-password') {
                            print("Add Your Password Correctly!");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    makeText("Add Your Password Correctly!"),
                              ),
                            );
                          } else if (e.code == 'user-not-found') {
                            print("Add Your Email Correctly!");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: makeText("Add Your Email Correctly!"),
                              ),
                            );
                          }
                        }
                      }
                    },
                    minimumSize: Size(
                      size.width * 0.5,
                      size.height * 0.05,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      makeText("If you don\'t have an account?"),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      makeTextButton("Signup", onPressed: () {
                        push(context, SignupScreen());
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
