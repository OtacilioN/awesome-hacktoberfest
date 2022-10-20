class User {
  String? message;
  String? token;
  String? id;
  String? createdAt;
  String? updatedAt;

  User({this.message, this.token, this.id, this.createdAt, this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['_id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
