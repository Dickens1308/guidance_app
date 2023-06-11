import 'progress.dart';

class Question {
  int? id;
  String? title;
  String? slug;
  String? choiceOne;
  String? choiceTwo;
  String? choiceThree;
  String? correctAnswer;
  String? codeImageUrl;
  int? topicId;
  List<Progress>? progress;

  Question({
    this.id,
    this.title,
    this.slug,
    this.choiceOne,
    this.choiceTwo,
    this.choiceThree,
    this.correctAnswer,
    this.codeImageUrl,
    this.topicId,
    this.progress,
  });

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    choiceOne = json['choice_one'];
    choiceTwo = json['choice_two'];
    choiceThree = json['choice_three'];
    correctAnswer = json['correct_answer'];
    codeImageUrl = json['code_image_url'];
    topicId = json['course_id'];

    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(Progress.fromJson(v));
      });
    }
  }
}
