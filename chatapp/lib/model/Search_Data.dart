class Search_Data {
  String? sId;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Search_Data(
      {this.sId,
      this.email,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Search_Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> Search_Data = new Map<String, dynamic>();
    Search_Data['_id'] = this.sId;
    Search_Data['email'] = this.email;
    Search_Data['password'] = this.password;
    Search_Data['createdAt'] = this.createdAt;
    Search_Data['updatedAt'] = this.updatedAt;
    Search_Data['__v'] = this.iV;
    return Search_Data;
  }
}
