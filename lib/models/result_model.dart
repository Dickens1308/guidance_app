import 'question.dart';

class ResultModel {
  int? correct;
  int? incorrect;
  int? total;
  List<Question>? questions;

  ResultModel({
    this.correct,
    this.incorrect,
    this.total,
    this.questions,
  });

  ResultModel.fromJson(Map<String, dynamic> json) {
    correct = json['correct'];
    incorrect = json['incorrect'];
    total = json['total'];

    if (json['questions'] != null) {
      questions = <Question>[];
      json['questions'].forEach((v) {
        questions!.add(Question.fromJson(v));
      });
    }
  }
}
