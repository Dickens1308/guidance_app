class Course {
  int? id;
  String? title;
  String? slug;
  int? languageId;
  String? createdAt;
  String? updatedAt;
  int? questionCount;
  int? videosCount;
  int? progressCount;
  // List<Videos>? videos;

  Course({
    this.id,
    this.title,
    this.slug,
    this.languageId,
    this.createdAt,
    this.updatedAt,
    this.questionCount,
    this.videosCount,
    this.progressCount,
    // this.videos,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    languageId = json['language_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionCount = json['question_count'];
    videosCount = json['videos_count'];
    progressCount = json['progress_count_count'];
    // if (json['videos'] != null) {
    //   videos = <Videos>[];
    //   json['videos'].forEach((v) {
    //     videos!.add(Videos.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['language_id'] = languageId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['question_count'] = questionCount;
    data['videos_count'] = videosCount;
    data['progress_count_count'] = progressCount;
    // if (videos!.isNotEmpty) {
    //   data['videos'] = videos!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Videos {
  int? courseId;
  String? location;
  String? title;

  Videos({this.courseId, this.location});

  Videos.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    location = json['location'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['location'] = location;
    data['title'] = title;

    return data;
  }
}
