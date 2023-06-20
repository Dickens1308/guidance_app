import 'package:flutter/material.dart';

class AgeFieldForm extends StatelessWidget {
  const AgeFieldForm(
      {Key? key, required this.controller, required this.focusNode})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.requestFocus();
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextFormField(
          focusNode: focusNode,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // validator: (input) => int.parse(input!) <= 0
          //     ? "Age cannot bel less than 1"
          //     : null,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Enter your age",
            labelText: "Age",
            labelStyle: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
            hintStyle: const TextStyle(
              color: Colors.white54,
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
