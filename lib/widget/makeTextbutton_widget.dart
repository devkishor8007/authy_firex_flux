import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:flutter/material.dart';

Widget makeTextButton(
  String textString, {
  Function()? onPressed,
}) {
  return TextButton(onPressed: onPressed, child: makeText(textString));
}
