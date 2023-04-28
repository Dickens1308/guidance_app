// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guidance/models/question.dart';
import 'package:guidance/providers/question_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/course_question.dart';
import '../widgets/screen_loader.dart';

class CourseTest extends StatefulWidget {
  const CourseTest({Key? key, required this.question}) : super(key: key);

  final Question question;

  static const routeName = "/course_test";

  @override
  State<CourseTest> createState() => _CourseTestState();
}

class _CourseTestState extends State<CourseTest> {
  List<String> myList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      QuestionProvider provider =
          Provider.of<QuestionProvider>(context, listen: false);

      await provider.setMyList(widget.question);
      if (widget.question.progress != null) {
        if (widget.question.progress!.isNotEmpty) {
          String choice = widget.question.progress![0].selectAnswer!;
          int answer = choice == 'a'
              ? 0
              : choice == 'b'
                  ? 1
                  : 2;

          await provider.setChoice(answer);
        } else {
          await provider.setChoice(null);
        }
      } else {
        await provider.setChoice(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<QuestionProvider>(
      builder: (context, provider, child) {
        return provider.loading
            ? const LoadingScreen()
            : Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: const Text("Question"),
                ),
                body: provider.questionList.isEmpty
                    ? buildNotFound(size)
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: size.height,
                          width: size.width,
                          child: buildScreen(provider, size),
                        ),
                      ),
              );
      },
    );
  }

  SizedBox buildScreen(QuestionProvider provider, Size size) {
    Question question = widget.question;
    String? answer = '';
    if (provider.wrong) {
      answer = question.correctAnswer == 'a'
          ? question.choiceOne
          : question.correctAnswer == 'b'
              ? question.choiceTwo
              : question.choiceThree;
    }

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseQuestion(question: question, provider: provider),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                if (provider.wrong)
                  SizedBox(
                    height: 80,
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: 'Make sure to pick ',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                        children: [
                          TextSpan(
                            text: answer,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (!provider.wrong) const SizedBox(height: 80),
                SizedBox(
                  width: size.width,
                  child: IgnorePointer(
                    ignoring: provider.choice != null ? false : true,
                    child: CupertinoButton(
                      onPressed: () => nextBackFunction(provider, question),
                      color: provider.choice != null
                          ? Colors.deepPurple.withOpacity(.8)
                          : Colors.deepPurple.withOpacity(.3),
                      borderRadius: BorderRadius.circular(8),
                      child: const Text(
                        'Submit',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildNotFound(Size size) {
    return SizedBox(
      height: size.height * .7,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'No question found',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Check your connection or try to reload the screen to get questions',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextBackFunction(QuestionProvider provider, Question question) async {
    bool isAnswered = await provider.answerQuestionAndGoNext(context, question);

    if (isAnswered) {
      Navigator.of(context).pop(true);
    }
  }
}
