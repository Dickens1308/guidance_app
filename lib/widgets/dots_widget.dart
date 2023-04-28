import 'package:flutter/material.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        dots(),
        dots(),
        dots(),
      ],
    );
  }

  Container dots() {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
