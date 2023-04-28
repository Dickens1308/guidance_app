// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/question.dart';
import '../providers/question_provider.dart';
import '../widgets/screen_loader.dart';
import 'learn_question.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({Key? key, required this.course}) : super(key: key);

  final Course course;

  static const routeName = "/question_list";

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  int count = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      QuestionProvider provider =
          Provider.of<QuestionProvider>(context, listen: false);

      await provider.getAllQuestionById(context, widget.course.id!);
      await provider.setCourse(widget.course);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(
      builder: (context, provider, child) {
        return provider.loading
            ? const LoadingScreen()
            : WillPopScope(
                onWillPop: () async {
                  Navigator.of(context).pop(true);
                  return true;
                },
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.questionList.length,
                            itemBuilder: (context, index) {
                              Question question = provider.questionList[index];
                              bool isAnswered =
                                  question.progress!.isNotEmpty ? true : false;

                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async =>
                                    questionFun(index, provider, question),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        index > provider.course.progressCount!
                                            ? Colors.black54
                                            : Colors.deepPurpleAccent
                                                .withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.book,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          height: 65,
                                          child: Text(
                                            question.title!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (index >
                                                provider.course.progressCount!)
                                              const Icon(
                                                Icons.lock_outline,
                                                color: Colors.grey,
                                              ),
                                            if (isAnswered)
                                              const Icon(
                                                Icons.check,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            const SizedBox(width: 6),
                                          ],
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
                ),
              );
      },
    );
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
        });
      }
    }
  }

  void questionFun(index, QuestionProvider provider, question) async {
    if (kDebugMode) {
      print(
          "Index is $index and q length ${provider.questionList.length} && progress count is ${provider.course.progressCount!}");
    }
    try {
      if (index == 0 ||
          index <= provider.course.progressCount!) {
        sendToLearning(question, provider);
      } else {
        Fluttertoast.showToast(
          msg: "Finish the previous question before continue",
          backgroundColor: Theme.of(context).primaryColor,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<bool> sendToLearning(question, provider) async {
    Navigator.pushNamed(context, LearnQuestion.routeName, arguments: question)
        .then((value) {
      if (value != null && value == true) {
        if (kDebugMode) {
          print("The pop returned is $value");
        }
        questionAnsweredCount(provider);
        return true;
      }
    });

    return false;
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
