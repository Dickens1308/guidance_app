import 'package:flutter/material.dart';
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
        height: size.height * .02,
        width: size.width * .3,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              language.title == 'Python'
                  ? Ionicons.logo_python
                  : language.title == 'Ruby'
                      ? Ionicons.logo_nodejs
                      : Ionicons.logo_tableau,
              size: 40,
            ),
            Text(
              "${language.title}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
