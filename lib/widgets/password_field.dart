import 'package:flutter/material.dart';

class PasswordFieldForm extends StatelessWidget {
  const PasswordFieldForm(
      {Key? key,
        required this.controller,
        required this.viewPassword,
        required this.function, required this.focusNode})
      : super(key: key);
  final TextEditingController controller;
  final bool viewPassword;
  final Function function;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
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
              color: Colors.white,
            ),
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(top: 19),
              child: IconButton(
                onPressed: () => function(),
                icon: Icon(
                  viewPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            border: buildOutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  UnderlineInputBorder buildOutlineInputBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    );
  }
}