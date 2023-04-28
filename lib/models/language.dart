class Language {
  String? id;
  String? title;

  Language({this.id, this.title});

  Language.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    return data;
  }
}
