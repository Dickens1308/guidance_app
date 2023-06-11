import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guidance/models/course.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../screens/course_test.dart';
import '../screens/results.dart';

class CourseSliderItem extends StatelessWidget {
  const CourseSliderItem({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // if (course.questionCount == course.progressCount) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, ResultScreen.routeName, (route) => false,
        //       arguments: course);
        // } else {
        //   Navigator.pushNamed(context, CourseTest.routeName, arguments: course);
        // }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: size.height,
        width: size.width,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                // blurRadius: .4,
                // offset: Offset(0, 0),
                color: Colors.white.withOpacity(.06),
              ),
            ]),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 30),
              SvgPicture.asset(
                "assets/svg/books-book-svgrepo-com.svg",
                height: size.height * .16,
                width: size.width * .3,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  course.title!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(left: 10, top: 25),
              //   height: size.height * .008,
              //   width: double.infinity,
              //   child: LinearPercentIndicator(
              //     width: size.width * .65,
              //     lineHeight: 10,
              //     barRadius: const Radius.circular(8),
              //     percent: course.progressCount! / course.questionCount!,
              //     backgroundColor: Colors.grey.shade300,
              //     progressColor: const Color(0xff152238),
              //   ),
              // ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Questions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     text: "${course.progressCount}",
                    //     style: const TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16,
                    //       color: Colors.black,
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: "/${course.questionCount}",
                    //         style: const TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 16,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
