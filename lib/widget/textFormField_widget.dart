import 'package:flutter/material.dart';

Widget makeTextField(
    {String? hintText,
    TextEditingController? controller,
    bool? obscureText,
    Widget? suffixIcon,
    FocusNode? focusNode,
    Function(String)? onFieldSubmitted,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    validator,
    bool? autofocus}) {
  return TextFormField(
    autofocus: autofocus ?? false,
    focusNode: focusNode,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    onFieldSubmitted: onFieldSubmitted,
    validator: validator,
    controller: controller,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.06),
    ),
  );
}

Widget makeUploadTextField(
    {String? hintText,
    TextEditingController? controller,
    FocusNode? focusNode,
    Function(String)? onFieldSubmitted,
    TextInputAction? textInputAction,
    validator,
    bool? autofocus}) {
  return TextFormField(
    validator: validator,
    autofocus: autofocus ?? false,
    focusNode: focusNode,
    textInputAction: textInputAction,
    onFieldSubmitted: onFieldSubmitted,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.06),
    ),
  );
}
