import 'package:newsapp2/core/base/base_model.dart';

class CommentModel extends IBaseModel {
  List<Comments>? comments;

  CommentModel({this.comments});

  CommentModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  fromJson(json) {
    return CommentModel.fromJson(json);
  }
}

class Comments {
  String? sId;
  String? body;
  int? date;
  String? userId;
  String? username;
  String? newsUrl;
  int? likeCount;
  int? dislikeCount;

  Comments(
      {this.sId,
      this.body,
      this.date,
      this.userId,
      this.username,
      this.newsUrl,
      this.likeCount,
      this.dislikeCount});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    body = json['body'];
    date = json['date'];
    userId = json['userId'];
    username = json['username'];
    newsUrl = json['newsUrl'];
    likeCount = json['likeCount'];
    dislikeCount = json['dislikeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['body'] = body;
    data['date'] = date;
    data['userId'] = userId;
    data['username'] = username;
    data['newsUrl'] = newsUrl;
    data['likeCount'] = likeCount;
    data['dislikeCount'] = dislikeCount;
    return data;
  }
}
