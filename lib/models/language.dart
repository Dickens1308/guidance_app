class Language {
  int id;
  String title;

  Language({required this.id, required this.title});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    return data;
  }
}
