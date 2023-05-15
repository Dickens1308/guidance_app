import 'package:flutter/material.dart';

class EmailFieldForm extends StatelessWidget {
  const EmailFieldForm(
      {Key? key, required this.controller, required this.focusNode})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        focusNode.requestFocus();
      },
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: buildOutlineInputBorder(),
          enabledBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  UnderlineInputBorder buildOutlineInputBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
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
