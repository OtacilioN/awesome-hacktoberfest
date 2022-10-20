class Data {
  String? sId;
  String? receivedUser;
  String? receivedUserEmail;
  String? sentUser;
  String? sentUserEmail;
  String? messageText;
  String? showStatus;
  String? unread;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? imagePath;

  Data(
      {this.sId,
      this.receivedUser,
      this.receivedUserEmail,
      this.sentUser,
      this.sentUserEmail,
      this.messageText,
      this.showStatus,
      this.unread,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.imagePath});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receivedUser = json['receivedUser'];
    receivedUserEmail = json['receivedUserEmail'];
    sentUser = json['sentUser'];
    sentUserEmail = json['sentUserEmail'];
    messageText = json['messageText'];
    showStatus = json['showStatus'];
    unread = json['unread'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['receivedUser'] = this.receivedUser;
    data['receivedUserEmail'] = this.receivedUserEmail;
    data['sentUser'] = this.sentUser;
    data['sentUserEmail'] = this.sentUserEmail;
    data['messageText'] = this.messageText;
    data['showStatus'] = this.showStatus;
    data['unread'] = this.unread;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
