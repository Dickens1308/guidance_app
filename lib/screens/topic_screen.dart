import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guidance/models/topic.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';
import '../providers/topic_provider.dart';
import '../widgets/dots_widget.dart';
import '../widgets/screen_loader.dart';
import 'questions_list.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key, required this.course}) : super(key: key);
  static const routeName = "/topic_screen";

  final Course course;

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  int count = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      TopicProvider provider =
          Provider.of<TopicProvider>(context, listen: false);

      await provider.getAllTopic(context, widget.course.id);
      countAllCourseCompleted(provider);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<TopicProvider>(builder: (context, provider, child) {
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
                          Topic topic = provider.list[index];
                          bool isCompleted = false;
                          bool inProgress = false;
                          bool isPrevCompleted = false;

                          if (topic.progressCount == topic.questionCount) {
                            isCompleted = true;
                          }

                          if (index != 0) {
                            Topic topic2 = provider.list[index - 1];
                            if (topic2.progressCount == topic2.questionCount) {
                              isPrevCompleted = true;
                            }
                          }

                          if (topic.progressCount > 0) {
                            inProgress = true;
                          }

                          return GestureDetector(
                            onTap: () => courseFun(index, provider, topic,
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
                                  topic.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${topic.progressCount} / ${topic.questionCount}",
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

  void countAllCourseCompleted(TopicProvider provider) async {
    count = 0;
    if (provider.list.isNotEmpty) {
      for (var element in provider.list) {
        if (element.questionCount == element.progressCount) {
          count++;
        }
      }

      setState(() {});

      if (kDebugMode) {
        print("There are $count topic completed");
      }
    }
  }

  void courseFun(
      index, TopicProvider provider, course, isCompleted, inProgress) async {
    if (index == 0 || inProgress || isCompleted) {
      await Navigator.pushNamed(context, QuestionListScreen.routeName,
              arguments: course)
          .then((value) async {
        await provider.getAllTopic(context, widget.course.id);
      });
    } else {
      Fluttertoast.showToast(
        msg: "Finish the previous topic before learning new topic",
        backgroundColor: Theme.of(context).primaryColor,
      );
    }
  }
}
