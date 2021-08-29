import 'package:authy_firex_flux/auth_service.dart';
import 'package:authy_firex_flux/main.dart';
import 'package:authy_firex_flux/widget/error_call_widget.dart';
import 'package:authy_firex_flux/widget/makeElevatedButton_widget.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:authy_firex_flux/widget/makeTextbutton_widget.dart';
import 'package:authy_firex_flux/widget/route_pass_widget.dart';
import 'package:authy_firex_flux/widget/textFormField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _showPassword = true;
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _pass;
  late TextEditingController _address;

  late FocusNode femail;
  late FocusNode fpass;
  late FocusNode fname;
  late FocusNode faddress;

  @override
  void initState() {
    _email = TextEditingController();
    _pass = TextEditingController();
    _name = TextEditingController();
    _address = TextEditingController();
    femail = FocusNode();
    fpass = FocusNode();
    fname = FocusNode();
    faddress = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    femail.dispose();
    fpass.dispose();
    fname.dispose();
    faddress.dispose();

    _email.dispose();
    _pass.dispose();
    _name.dispose();
    _address.dispose();
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
              key: _globalKey,
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
                    "SignUp",
                    fontWeight: FontWeight.bold,
                    textColor: Colors.grey,
                    size: Theme.of(context).textTheme.headline6!.fontSize,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  makeTextField(
                    autofocus: true,
                    controller: _name,
                    hintText: "Enter your Name",
                    obscureText: false,
                    focusNode: fname,
                    onFieldSubmitted: (next) {
                      fname.unfocus();
                      FocusScope.of(context).requestFocus(femail);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val!.isEmpty) return "Please Add Empty FIeld!";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.013,
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
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (next) {
                      fpass.unfocus();
                      FocusScope.of(context).requestFocus(faddress);
                    },
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) {
                      if (val!.length < 7) return "More than 7 digits";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  makeTextField(
                    autofocus: true,
                    controller: _address,
                    hintText: "Enter your Address",
                    obscureText: false,
                    focusNode: faddress,
                    textInputAction: TextInputAction.done,
                    validator: (val) {
                      if (val!.isEmpty) return "Please Add this Field";
                      return null;
                    },
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(
                    height: size.height * 0.013,
                  ),
                  makeElevatedButton(
                    context,
                    "SignUp",
                    textSize: Theme.of(context).textTheme.button!.fontSize,
                    onPressed: () async {
                      final isValid = _globalKey.currentState!.validate();
                      if (isValid) {
                        try {
                          final res = await AuthServices.signupwithEmail(
                            email: _email.text.trim().toLowerCase(),
                            password: _pass.text.trim(),
                          );

                          if (res != null) {
                            print("Successfully Created Account");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: makeText("Welcome to Authy FirexFlux"),
                              ),
                            );
                            pushReplacement(context, FirebaseAuthChecker());
                          } else {
                            errorMessage(context, size);
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print("please set your strong password!");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: makeText(
                                    "please set your strong password!"),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            print("Email Already Use!");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: makeText("Email Already Use!"),
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
                      makeText("If you have an account?"),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      makeTextButton("Login", onPressed: () {
                        pop(context);
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
