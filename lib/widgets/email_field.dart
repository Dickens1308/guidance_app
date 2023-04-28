import 'package:flutter/material.dart';

class EmailFieldForm extends StatelessWidget {
  const EmailFieldForm({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        validator: (input) =>
        input!.isValidEmail() ? null : "check your email if is correct",
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Enter your email address",
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
          labelText: "Email",
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          prefixIcon: const Icon(
            Icons.mail,
            color: Colors.white,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white54,
      ),
      gapPadding: 10,
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
