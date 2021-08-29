import 'package:authy_firex_flux/screen_type/In_Drawer/main_openDrawer.dart';
import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  List color = [
    Colors.indigo,
    Colors.black,
    Colors.pink,
    Colors.brown,
    Colors.green,
    Colors.grey
  ];
  @override
  Widget build(BuildContext context) {
    color.shuffle();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: makeText("Authy App"),
      ),
      drawer: OpenMainDrawer(),
      body: ListView(
        children: [
          ...color.map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.3,
                  color: e,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
