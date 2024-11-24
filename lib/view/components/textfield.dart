// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  var suffixIcon;

  CustomTextfield(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.4),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.4, color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
          )),
    );
  }
}
