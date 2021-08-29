import 'package:authy_firex_flux/auth_service.dart';
import 'package:authy_firex_flux/main.dart';
import 'package:authy_firex_flux/screen_type/In_Drawer/main_openDrawer.dart';
import 'package:authy_firex_flux/widget/makeElevatedButton_widget.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:authy_firex_flux/widget/route_pass_widget.dart';
import 'package:authy_firex_flux/widget/textFormField_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingDrawer extends StatefulWidget {
  @override
  _SettingDrawerState createState() => _SettingDrawerState();
}

class _SettingDrawerState extends State<SettingDrawer> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: makeText("Setting"),
      ),
      drawer: OpenMainDrawer(),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: makeTextField(
                        hintText: 'Enter your New Password',
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        validator: (val) {
                          if (val!.isEmpty || val.length < 7)
                            return "Insert password more than 7 digits";
                          return null;
                        }),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  Flexible(
                    flex: 1,
                    child: makeElevatedButton(context, "Change Password",
                        textSize: Theme.of(context).textTheme.caption!.fontSize,
                        minimumSize: Size(
                          size.width * 0.00,
                          size.height * 0.06,
                        ), onPressed: () async {
                      final isValid = _globalKey.currentState!.validate();
                      if (isValid) {
                        try {
                          print("yes");
                          final res = await AuthServices.changepassword(
                            newPassword: _password.text.trim(),
                          );
                          print(res);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              content: makeText("Change Your Password!"),
                            ),
                          );
                          await AuthServices.logout();
                          pushReplacement(context, FirebaseAuthChecker());
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print("No user found for this email");
                          }
                        }
                      }
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
