// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/question.dart';
import 'course_test.dart';

class LearnQuestion extends StatefulWidget {
  const LearnQuestion({Key? key, required this.question}) : super(key: key);

  final Question question;

  static const routeName = "/learn_question";

  @override
  State<LearnQuestion> createState() => _LearnQuestionState();
}

class _LearnQuestionState extends State<LearnQuestion> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Short notes"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * .79,
                child: Column(
                  children: [
                    Text(
                      widget.question.learningTitle.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.question.learningDesc.toString(),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width,
                child: CupertinoButton(
                  onPressed: () async {
                    dynamic isAnswered = await Navigator.pushNamed(
                      context,
                      CourseTest.routeName,
                      arguments: widget.question,
                    );

                    if (isAnswered != null && isAnswered) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  color: Colors.deepPurple.withOpacity(.8),
                  borderRadius: BorderRadius.circular(8),
                  child: const Text(
                    'Continue',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
