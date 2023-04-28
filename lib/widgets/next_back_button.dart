import 'package:flutter/material.dart';

class NextBackButton extends StatelessWidget {
  const NextBackButton({
    Key? key,
    required this.function,
    required this.title,
  }) : super(key: key);

  final Function function;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => function(title),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: size.height * .07,
        width: size.width * .27,
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
