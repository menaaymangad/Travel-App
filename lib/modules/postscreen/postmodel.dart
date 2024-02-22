class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String text;
  late String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}

class CommentsModel {
  late String name;
  late String uId;
  late String image;
  String? commentImage;
  late String date;
  String? text;

  CommentsModel({
    required this.uId,
    required this.name,
    required this.image,
    this.text,
    this.commentImage,
    required this.date,
  });
  CommentsModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];

    uId = json['uId'];

    image = json['image'];
    commentImage = json['commentImage'];
    date = json['date'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'text': text,
      'commentImage': commentImage,
      'date': date,
    };
  }
}
