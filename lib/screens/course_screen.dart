import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/language.dart';
import '../providers/course_provider.dart';
import '../widgets/dots_widget.dart';
import '../widgets/screen_loader.dart';
import 'topic_screen.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key, required this.language}) : super(key: key);
  static const routeName = "/course_screen";

  final Language language;

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int count = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CourseProvider provider =
          Provider.of<CourseProvider>(context, listen: false);

      await provider.getAllCourse(context, widget.language.id);
      countAllCourseCompleted(provider);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<CourseProvider>(builder: (context, provider, child) {
      return provider.loading
          ? const LoadingScreen()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          count != provider.list.length
                              ? SvgPicture.asset(
                                  'assets/svg/achievement-challenge-medal-svgrepo-com.svg',
                                  height: size.height * .25,
                                  width: size.width,
                                  // color: Colors.white70,
                                )
                              : Lottie.asset(
                                  'assets/json/59344-congratulation-badge-animation.json',
                                  height: size.height * .25,
                                ),
                          if (count != provider.list.length)
                            Positioned(
                              right: 90,
                              top: 50,
                              child: Text(
                                "${provider.list.length}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (provider.list.isNotEmpty)
                      ListView.separated(
                        itemCount: provider.list.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Course course = provider.list[index];
                          bool isCompleted = false;
                          bool inProgress = false;
                          bool isPrevCompleted = false;

                          if (course.progressCount == course.topicsCount) {
                            isCompleted = true;
                          }

                          if (index != 0) {
                            Course course2 = provider.list[index - 1];
                            if (course2.progressCount == course2.topicsCount) {
                              isPrevCompleted = true;
                            }
                          }

                          if (course.progressCount > 0) {
                            inProgress = true;
                          }

                          return GestureDetector(
                            onTap: () => courseFun(index, provider, course,
                                isPrevCompleted, inProgress),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: (index == 0 ||
                                            inProgress ||
                                            isPrevCompleted)
                                        ? isCompleted
                                            ? Colors.deepPurpleAccent
                                                .withOpacity(.2)
                                            : Colors.deepPurpleAccent
                                                .withOpacity(.3)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(140),
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(140),
                                    ),
                                    child: Icon(
                                      (inProgress ||
                                              index == 0 ||
                                              isPrevCompleted)
                                          ? isCompleted
                                              ? Ionicons.checkmark
                                              : Ionicons.flash
                                          : Ionicons.lock_closed,
                                      color: Colors.grey,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  course.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${course.progressCount} / ${course.topicsCount}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const DotsWidget();
                        },
                      ),
                  ],
                ),
              ),
            );
    });
  }

  void countAllCourseCompleted(CourseProvider provider) async {
    count = 0;
    if (provider.list.isNotEmpty) {
      for (var element in provider.list) {
        if (element.progressCount == element.topicsCount) {
          count++;
        }
      }

      setState(() {});

      if (kDebugMode) {
        print("There are $count course completed");
      }
    }
  }

  void courseFun(index, provider, course, isCompleted, inProgress) async {
    if (index == 0 || inProgress || isCompleted) {
      await Navigator.pushNamed(context, TopicScreen.routeName,
              arguments: course)
          .then((value) async {
        await Provider.of<CourseProvider>(context, listen: false)
            .getAllCourse(context, widget.language.id);
      });
    } else {
      Fluttertoast.showToast(
        msg: "Finish the previous course before learning new course",
        backgroundColor: Theme.of(context).primaryColor,
      );
    }

    // if (index > 0) {
    //   Course courseCheck = provider.list[index - 1];
    //   if (courseCheck.progressCount == courseCheck.questionCount) {
    //     dynamic value = await Navigator.pushNamed(
    //         context, QuestionListScreen.routeName,
    //         arguments: course);
    //
    //     if (kDebugMode) {
    //       print("Pop screen value is $value");
    //     }
    //     if (value != null && value == true) {
    //       // ignore: use_build_context_synchronously
    //       Provider.of<CourseProvider>(context, listen: false)
    //           .getAllCourse(context, num.parse(widget.language.id!));
    //
    //       setState(() {});
    //     }
    //   } else {
    //     Fluttertoast.showToast(
    //       msg: "Finish the previous course before learning new course",
    //       backgroundColor: Theme.of(context).primaryColor,
    //     );
    //   }
    // } else {
    //   dynamic value = await Navigator.pushNamed(
    //       context, QuestionListScreen.routeName,
    //       arguments: course);
    //
    //   if (kDebugMode) {
    //     print("Pop screen value is $value");
    //   }
    //   if (value != null && value == true) {
    //     // ignore: use_build_context_synchronously
    //     Provider.of<CourseProvider>(context, listen: false)
    //         .getAllCourse(context, num.parse(widget.language.id!));
    //     countAllCourseCompleted(provider);
    //     setState(() {});
    //   }
    // }
  }
}
