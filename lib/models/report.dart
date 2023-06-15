class Report {
  final num pythonQuestion;
  final num pythonAnswers;
  final num scratchQuestion;
  final num scratchAnswers;
  final num rubyQuestion;
  final num rubyAnswers;

  Report({
    required this.pythonQuestion,
    required this.pythonAnswers,
    required this.scratchQuestion,
    required this.scratchAnswers,
    required this.rubyQuestion,
    required this.rubyAnswers,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      pythonQuestion: json['pythonQuestion'],
      pythonAnswers: json['pythonAnswers'],
      scratchQuestion: json['scratchQuestion'],
      scratchAnswers: json['scratchAnswers'],
      rubyQuestion: json['RubyQuestion'],
      rubyAnswers: json['RubyAnswers'],
    );
  }
}
