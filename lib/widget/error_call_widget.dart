import 'package:flutter/material.dart';

import 'makeText_widget.dart';

errorMessage(BuildContext context, Size size) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.dashboard_customize),
              SizedBox(
                width: size.width * 0.03,
              ),
              makeText("Error Message"),
            ],
          ),
          content: makeText("Please Insert the right Email and Password!"),
        );
      });
}
