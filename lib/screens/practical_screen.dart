// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/topic.dart';
import '../providers/question_provider.dart';
import '../widgets/screen_loader.dart';
import 'learn_question.dart';
import 'practical_idea.dart';

class PracticalScreen extends StatefulWidget {
  const PracticalScreen({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  static const routeName = "/practical_Screen";

  @override
  State<PracticalScreen> createState() => _PracticalScreenState();
}

class _PracticalScreenState extends State<PracticalScreen> {
  int count = 0;
  Topic? topic;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      QuestionProvider provider =
          Provider.of<QuestionProvider>(context, listen: false);

      await provider.getAllQuestionById(context, widget.topic.id);
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
                appBar: AppBar(elevation: 0),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (topic != null) topicContent(context),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: CupertinoButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              PracticalIDE.routeName,
                              arguments: topic,
                            ),
                            color: Theme.of(context).primaryColor,
                            child: const Text("Continue to Test"),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              QuestionsOnly.routeName,
                              arguments: topic,
                            ),
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                )),
                            child: const Text("Skip Test"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  Column topicContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        if (topic!.learningDescSub != null)
          Text(
            '${topic!.learningDescSub}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 20),
        if (topic!.codeExample != null)
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Example code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${topic!.codeExample}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 20),
        if (topic!.codeExplanation != null)
          Text(
            '${topic!.codeExplanation}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 20),
        // if (topic!.codePractice != null)
        //   Container(
        //     width: MediaQuery.of(context).size.width,
        //     decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(.7),
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.all(15.0),
        //       child: Text(
        //         '${topic!.codePractice}',
        //         style: const TextStyle(
        //           color: Colors.green,
        //           fontSize: 18,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
