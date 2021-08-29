import 'package:authy_firex_flux/widget/makeText_widget.dart';
import 'package:flutter/material.dart';

Widget makeElevatedButton(
  BuildContext context,
  String textString, {
  Function()? onPressed,
  Size? minimumSize,
  double? textSize,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    child: makeText(
      textString,
      size: textSize,
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.indigo,
      onPrimary: Colors.white,
      textStyle: TextStyle(
        fontSize: Theme.of(context).textTheme.button!.fontSize,
      ),
      minimumSize: minimumSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
      ),
    ),
  );
}
