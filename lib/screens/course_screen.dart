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
import 'python_future.dart';
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
                title: Text(widget.language.title),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.language.title} Career',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pushNamed(
                              context, FutureScreen.routeName,
                              arguments: widget.language),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                          bool noQuestion = false;

                          if (course.progressCount == course.topicsCount) {
                            isCompleted = true;
                          }

                          if (index != 0) {
                            Course course2 = provider.list[index - 1];
                            if (course2.progressCount == course2.topicsCount) {
                              isPrevCompleted = true;
                            }
                          }

                          if ((course.topicsCount - course.progressCount) <=
                              1) {
                            noQuestion = true;
                          }

                          if (course.progressCount > 0) {
                            inProgress = true;
                          }

                          return GestureDetector(
                            onTap: () => courseFun(index, provider, course,
                                isPrevCompleted, inProgress, noQuestion),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: (index == 0 ||
                                            inProgress ||
                                            isPrevCompleted || noQuestion)
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
                                              isPrevCompleted || noQuestion)
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

  void courseFun(
      index, provider, course, isCompleted, inProgress, noQuestion) async {
    if (index == 0 || inProgress || isCompleted || noQuestion) {
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
  }
}
