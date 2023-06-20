class Topic {
  int id;
  String title;
  String slug;
  String? learningTitle;
  String? learningDesc;
  String? learningDescSub;
  String? videoUrl;
  String? codeExample;
  String? codeExplanation;
  String? codePractice;
  int courseId;
  DateTime createdAt;
  DateTime updatedAt;
  int questionCount;
  int progressCount;

  String? codeFirstLine;
  String? codeSecondLine;
  String? codeThirdLine;
  String? codeFourthLine;
  String? codeFifthLine;
  String? codeSixLine;
  String? codeSevenLine;
  String? codeEightLine;
  String? codeNineLine;
  String? codeTenLine;

  Topic({
    required this.id,
    required this.title,
    required this.slug,
    this.learningTitle,
    this.learningDesc,
    this.learningDescSub,
    this.videoUrl,
    this.codeExample,
    this.codeExplanation,
    this.codePractice,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.questionCount,
    required this.progressCount,
    this.codeFirstLine,
    this.codeSecondLine,
    this.codeThirdLine,
    this.codeFourthLine,
    this.codeFifthLine,
    this.codeSixLine,
    this.codeSevenLine,
    this.codeEightLine,
    this.codeNineLine,
    this.codeTenLine,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      learningTitle: json['learning_title'],
      learningDesc: json['learning_desc'],
      learningDescSub: json['learning_desc_sub'],
      videoUrl: json['video_url'],
      codeExample: json['code_example'],
      codeExplanation: json['code_explanation'],
      codePractice: json['code_practise'],
      courseId: json['course_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      questionCount: json['questions_count'],
      progressCount: json['progress_count'],
      codeFirstLine: json["code_first_line"],
      codeSecondLine: json["code_second_line"],
      codeThirdLine: json["code_third_line"],
      codeFourthLine: json["code_fourth_line"],
      codeFifthLine: json["code_fifth_line"],
      codeSixLine: json["code_six_line"],
      codeSevenLine: json["code_seven_line"],
      codeEightLine: json["code_eight_line"],
      codeNineLine: json["code_nine_line"],
      codeTenLine: json["code_ten_line"],
    );
  }
}
