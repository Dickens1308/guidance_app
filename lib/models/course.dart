class Course {
  int id;
  String title;
  String slug;
  String? desc;
  String? subDesc;
  int languageId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int topicsCount;
  int progressCount;

  Course({
    required this.id,
    required this.title,
    required this.slug,
    required this.languageId,
    required this.topicsCount,
    required this.progressCount,
    this.desc,
    this.subDesc,
    this.createdAt,
    this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      desc: json['desc']??'',
      subDesc: json['sub_desc']??'',
      languageId: json['language_id'],
      topicsCount: json['topics_count'],
      progressCount: json['progress_count'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
