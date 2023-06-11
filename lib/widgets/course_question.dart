import 'package:flutter/material.dart';
import 'package:guidance/providers/question_provider.dart';

import '../models/question.dart';

class CourseQuestion extends StatelessWidget {
  const CourseQuestion({
    Key? key,
    required this.question,
    required this.provider,
  }) : super(key: key);

  final Question question;
  final QuestionProvider provider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * .69,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Text(
                  '${question.title}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              ),
              if (question.codeImageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Python Code',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,

                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${question.codeImageUrl}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,

                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.myList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildContainer(
                    context,
                    provider.myList[index],
                    provider.myList[index].toLowerCase().contains("error"),
                    index,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  buildContainer(BuildContext context, String title, bool error, int position) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (position == provider.choice) {
          provider.setChoice(null);
        } else {
          provider.setChoice(position);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: provider.choice == position
              ? Border.all(
                  width: 2,
                  color: provider.wrong ? Colors.red : const Color(0xff05e0f0),
                )
              : Border.all(color: Colors.transparent),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: provider.choice == position
                    ? provider.wrong
                        ? Colors.red
                        : const Color(0xff05e0f0)
                    : error
                        ? Colors.red
                        : Colors.white70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
