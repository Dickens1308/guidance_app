import 'package:flutter/material.dart';

class PasswordFieldForm extends StatelessWidget {
  const PasswordFieldForm(
      {Key? key,
        required this.controller,
        required this.viewPassword,
        required this.function})
      : super(key: key);
  final TextEditingController controller;
  final bool viewPassword;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: viewPassword,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (input) => input!.length < 4
            ? "Password length should have more than 4 characters"
            : null,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: "Enter your password",
          labelText: "Password",
          labelStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white54,
          ),
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            onPressed: () => function(),
            icon: Icon(
              viewPassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.white,
            ),
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