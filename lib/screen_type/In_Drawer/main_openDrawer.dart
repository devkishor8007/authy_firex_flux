import 'package:authy_firex_flux/auth_service.dart';
import 'package:authy_firex_flux/main.dart';
import 'package:authy_firex_flux/screen_type/In_Drawer/profile_drawer.dart';
import 'package:authy_firex_flux/screen_type/In_Drawer/setting_drawer.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:authy_firex_flux/widget/route_pass_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OpenMainDrawer extends StatefulWidget {
  @override
  _OpenMainDrawerState createState() => _OpenMainDrawerState();
}

class _OpenMainDrawerState extends State<OpenMainDrawer> {
  final email = FirebaseAuth.instance.currentUser!.email;

  final name = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: makeText('${email!.substring(0, 1)}'),
            ),
            accountName: makeText(name == null ? "Authy" : name!),
            accountEmail: makeText(email!),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: makeText("Profile"),
            onTap: () {
              pushReplacement(context, ProfileDrawer());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: makeText("Settings"),
            onTap: () {
              pushReplacement(context, SettingDrawer());
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: makeText("Logout"),
            onTap: () {
              AuthServices.logout();
              pushReplacement(context, FirebaseAuthChecker());
            },
          ),
        ],
      ),
    );
  }
}
