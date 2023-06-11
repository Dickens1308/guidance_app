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
    );
  }
}
