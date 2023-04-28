import 'package:flutter/material.dart';

class UsernameFieldForm extends StatelessWidget {
  const UsernameFieldForm({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (input) => input!.length < 4
            ? "Username length should have more than 4 characters"
            : null,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Enter your username",
          labelText: "Username",
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white54,
          ),
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
          prefixIcon: const Icon(
            Icons.person,
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
