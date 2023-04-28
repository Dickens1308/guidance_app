class Progress {
  int? id;
  String? selectAnswer;
  int? userId;
  int? questionId;

  Progress({
    this.id,
    this.selectAnswer,
    this.userId,
    this.questionId,
  });

  Progress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selectAnswer = json['select_answer'];
    userId = json['user_id'];
    questionId = json['question_id'].runtimeType == int
        ? json['question_id']
        : int.parse(json['question_id']);
  }
}
