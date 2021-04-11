import 'package:flutter/material.dart';

Widget inputText(
    TextEditingController controller,
    IconData icon,
    String labelText,
    TextInputType textInputType,
    bool obsecure,
    bool validate) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: labelText,
    ),
    keyboardType: textInputType,
    validator: (value) => validate == true
        ? value.isEmpty
            ? 'This field is requird'
            : null
        : null,
    obscureText: obsecure,
  );
}
