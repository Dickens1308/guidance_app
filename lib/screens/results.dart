import 'package:flutter/material.dart';
import 'package:guidance/models/question.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/question_provider.dart';
import '../widgets/screen_loader.dart';
import 'bottom.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.course}) : super(key: key);

  final Course course;

  static const routeName = "/result";

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<QuestionProvider>(context, listen: false);
      provider.getAllResultById(context, widget.course.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, BottomScreen.routeName, (route) => false);
        return true;
      },
      child: Consumer<QuestionProvider>(
        builder: (context, provider, child) {
          return provider.loading
              ? const LoadingScreen()
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Result'),
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, BottomScreen.routeName, (route) => false),
                      icon: const Icon(
                        Ionicons.arrow_back,
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                              top: 20,
                              right: 40,
                              bottom: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildColumn(provider, 'Correct'),
                                const SizedBox(width: 40),
                                buildColumn(provider, 'Incorrect'),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Divider(
                              height: 40,
                              color: Colors.white70,
                            ),
                          ),
                          if (provider.resultModel != null)
                            ListView.separated(
                              itemCount:
                                  provider.resultModel!.questions!.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                Question question =
                                    provider.resultModel!.questions![index];

                                String? correct = question.correctAnswer == 'a'
                                    ? question.choiceOne
                                    : question.correctAnswer == 'b'
                                        ? question.choiceTwo
                                        : question.choiceThree;

                                String? selected = question
                                            .progress![0].selectAnswer ==
                                        'a'
                                    ? question.choiceOne
                                    : question.progress![0].selectAnswer == 'b'
                                        ? question.choiceTwo
                                        : question.choiceThree;

                                return ListTile(
                                  title: Text(
                                    "Question ${index + 1}: ${question.title}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (question.codeImageUrl != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, left: 20, bottom: 20),
                                          child: Center(
                                            child: Image.network(
                                              question.codeImageUrl!,
                                              height: size.height * .25,
                                              width: size.width * .7,
                                            ),
                                          ),
                                        ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 6),
                                          Text(
                                            'Selected answer: $correct',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            'Correct answer: $selected',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    correct != selected
                                        ? Ionicons.close_circle
                                        : Ionicons.checkmark,
                                    size: 35,
                                    color: correct != selected
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Divider(
                                    height: 40,
                                    color: Colors.white70,
                                  ),
                                );
                              },
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  buildColumn(QuestionProvider provider, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.merge(
                const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
              ),
        ),
        Text(
          provider.resultModel == null
              ? ''
              : title == 'Correct'
                  ? provider.resultModel!.correct.toString()
                  : provider.resultModel!.incorrect.toString(),
          style: Theme.of(context).textTheme.headlineLarge!.merge(
                TextStyle(
                  color: title == 'Correct' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
      ],
    );
  }
}
