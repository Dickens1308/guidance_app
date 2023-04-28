class AppUser {
  User? user;
  String? token;
  String? message;

  AppUser({this.user, this.token, this.message});

  AppUser.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}

class User {
  int? id;
  String? name;
  num? parentId;
  String? email;

  User({
    this.id,
    this.name,
    this.parentId,
    this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['username'];
    parentId = json['parent_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = name;
    data['parent_id'] = parentId;
    data['email'] = email;
    return data;
  }
}
