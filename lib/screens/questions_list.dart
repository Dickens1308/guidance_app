// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/topic.dart';
import '../providers/question_provider.dart';
import '../widgets/screen_loader.dart';
import 'learn_question.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({Key? key, required this.topic}) : super(key: key);

  final Topic topic;

  static const routeName = "/question_list";

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
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
                  title: topic != null ? Text(topic!.title) : const SizedBox(),
                ),
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
                              QuestionsOnly.routeName,
                              arguments: topic,
                            ),
                            color: Theme.of(context).primaryColor,
                            child: const Text("Continue to questions"),
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
        Text(
          '${topic!.learningTitle}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${topic!.learningDesc}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        if (topic!.videoUrl != null) const Text("Video Url here"),
        const SizedBox(height: 10),
        Text(
          '${topic!.learningDesc}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Python code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${topic!.codeExample}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
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
        if (topic!.codePractice != null)
          Text(
            '${topic!.codePractice}',
            style: const TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
