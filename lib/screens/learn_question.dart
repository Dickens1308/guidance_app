// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/question.dart';
import '../models/topic.dart';
import '../providers/question_provider.dart';
import '../widgets/screen_loader.dart';
import 'course_test.dart';

class QuestionsOnly extends StatefulWidget {
  const QuestionsOnly({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  static const routeName = "/question_only";

  @override
  State<QuestionsOnly> createState() => _QuestionsOnlyState();
}

class _QuestionsOnlyState extends State<QuestionsOnly> {
  int count = 0;
  Topic? topic;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      QuestionProvider provider =
          Provider.of<QuestionProvider>(context, listen: false);

      await provider.getAllQuestionById(context, widget.topic.id);
      // await provider.setCourse(widget.topic);
    });

    Future.delayed(Duration.zero, () => topic = widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, provider, child) {
        return provider.loading
            ? const LoadingScreen()
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: const Text("Questions"),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.questionList.length,
                          itemBuilder: (context, index) {
                            Question question = provider.questionList[index];
                            bool isAnswered =
                                question.progress!.isNotEmpty ? true : false;

                            bool next = false;
                            if (index > 0) {
                              final question2 =
                                  provider.questionList[index - 1];
                              next =
                                  question2.progress!.isNotEmpty ? true : false;
                            }

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async => sendToLearning(
                                  question, provider, isAnswered, next, index),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (next || index == 0)
                                      ? Colors.black.withOpacity(.5)
                                      : Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 25, bottom: 20, right: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.book,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Question ${index + 1}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          isAnswered
                                              ? Icons.check
                                              : (next || index == 0)
                                                  ? Ionicons.flash
                                                  : Icons.lock_outline,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future<void> sendToLearning(Question question, QuestionProvider provider,
      isAnswered, next, index) async {
    if (isAnswered || next || index == 0) {
      Navigator.pushNamed(context, CourseTest.routeName, arguments: question)
          .then((value) async {
        await provider
            .getAllQuestionById(context, widget.topic.id)
            .then((value) {
          questionAnsweredCount(provider);
        });
      });
    } else {
      Fluttertoast.showToast(
        msg: "Finish the previous question before answering next question",
        backgroundColor: Theme.of(context).primaryColor,
      );
    }
  }

  void questionAnsweredCount(QuestionProvider provider) {
    if (provider.questionList.isNotEmpty) {
      count = 0;
      for (var element in provider.questionList) {
        if (element.progress!.isNotEmpty) {
          count++;
        }
      }

      if (count == provider.questionList.length) {
        loadingScreen(context);
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(true);
          Navigator.of(context).pop(true);
          Navigator.of(context).pop(true);
        });
      }
    }
  }


  Future loadingScreen(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Container(
          color: Colors.transparent,
          child: Center(
            child: Lottie.asset(
              'assets/json/55867-congratulation.json',
            ),
          ),
        );
      },
    );
  }
}
