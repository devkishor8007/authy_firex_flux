import 'package:authy_firex_flux/auth_service.dart';
import 'package:authy_firex_flux/widget/makeElevatedButton_widget.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:authy_firex_flux/widget/textFormField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: makeText("FirexFlux"),
        ),
        body: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              makeTextField(
                  hintText: 'Enter your email',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  validator: (val) {
                    if (val!.isEmpty) return "Insert Field";
                    return null;
                  }),
              makeElevatedButton(
                context,
                "Reset Password",
                onPressed: () async {
                  try {
                    final isValid = _globalKey.currentState!.validate();
                    if (isValid) {
                      final res = await AuthServices.resetpassword(
                        email: _email.text.trim().toLowerCase(),
                      );
                      print(res);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: makeText("Check Your Email!"),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print("No user found for this email");
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
