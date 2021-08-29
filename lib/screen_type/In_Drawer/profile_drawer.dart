import 'package:authy_firex_flux/auth_service.dart';
import 'package:authy_firex_flux/screen_type/In_Drawer/main_openDrawer.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:authy_firex_flux/widget/makeTextbutton_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileDrawer extends StatefulWidget {
  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final joinTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: makeText("My Profile"),
      ),
      drawer: OpenMainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          user!.emailVerified
              ? makeText(
                  "Verified",
                  textColor: Colors.indigo,
                )
              : makeTextButton("Email : $email", onPressed: () async {
                  await AuthServices.verifyEmail();
                }),
          makeText(
            "Join At : $joinTime",
          ),
        ],
      ),
    );
  }
}
