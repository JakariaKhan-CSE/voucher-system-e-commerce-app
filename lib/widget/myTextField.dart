import 'package:flutter/material.dart';
Widget myTextField(String hintText,TextEditingController controller){
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        hintText: hintText
    ),
  );
}