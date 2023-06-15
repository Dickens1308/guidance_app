import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

import '../models/language.dart';
import '../screens/course_screen.dart';

class GridTileLan extends StatelessWidget {
  const GridTileLan({
    super.key,
    required this.size,
    required this.language,
  });

  final Size size;
  final Language language;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pushNamed(
        context,
        CourseScreen.routeName,
        arguments: language,
      ),
      child: Container(
        height: size.height * .022,
        width: size.width * .3,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (language.id != 3)
              SvgPicture.asset(
                language.id == 1
                    ? "assets/svg/Python-logo-notext.svg"
                    : "assets/svg/Ruby_logo.svg",
                height: 80,
                width: 80,
              ),
            if (language.id == 3)
              Image.asset(
                "assets/svg/Scratch.logo.S.png",
                height: 90,
                width: 90,
              ),
            Text(
              language.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
