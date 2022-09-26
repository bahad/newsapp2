import 'package:newsapp2/core/base/base_model.dart';

class AddCommentModel extends IBaseModel {
  String? message;
  CreatedComment? createdComment;

  AddCommentModel({this.message, this.createdComment});

  AddCommentModel.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
    createdComment = json['createdComment'] != null
        ? CreatedComment.fromJson(json['createdComment'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (createdComment != null) {
      data['createdComment'] = createdComment!.toJson();
    }
    return data;
  }

  @override
  fromJson(json) {
    return AddCommentModel.fromJson(json);
  }
}

class CreatedComment {
  String? id;
  String? userId;
  String? body;
  int? date;
  String? newsUrl;
  int? likeCount;
  int? dislikeCount;

  CreatedComment(
      {this.id,
      this.userId,
      this.body,
      this.date,
      this.newsUrl,
      this.likeCount,
      this.dislikeCount});

  CreatedComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userId = json['userId'];
    date = json['date'];
    newsUrl = json['newsUrl'];
    likeCount = json['likeCount'];
    dislikeCount = json['dislikeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['body'] = body;
    data['date'] = date;
    data['newsUrl'] = newsUrl;
    data['likeCount'] = likeCount;
    data['dislikeCount'] = dislikeCount;
    return data;
  }
}
