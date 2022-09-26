import 'package:flutter/material.dart';
import 'package:newsapp2/core/init/network/network_manager.dart';
import 'package:newsapp2/pages/comment/comment_model.dart';

import '../pages/comment/add_comment_model.dart';

class CommentServices {
  final BuildContext? context;
  CommentServices({this.context});

  Future<dynamic> getCommentByNews(String newsUrl) async {
    return await NetworkManager.instance.get<CommentModel>(
      path: "/comment/getCommentByNews/$newsUrl",
      model: CommentModel(),
      context: context,
    );
  }

  Future<dynamic> getCommentByUser(String userID) async {
    return await NetworkManager.instance.get<CommentModel>(
      path: "/comment/getCommentByUser/$userID",
      model: CommentModel(),
      context: context,
    );
  }

  Future<dynamic> addComment(
    String body,
    num date,
    String username,
    String userId,
    String newsUrl,
  ) async {
    return await NetworkManager.instance.post<AddCommentModel>(
      data: {
        "body": body,
        "date": date.toString(),
        "userId": userId,
        "username": username,
        "newsUrl": newsUrl,
        "likeCount": 0,
        "dislikeCount": 0
      },
      path: "/comment/",
      model: AddCommentModel(),
      context: context,
    );
  }

  Future<dynamic> deleteComment(String commentID) async {
    return await NetworkManager.instance.delete<AddCommentModel>(
      path: "/comment/$commentID",
      model: AddCommentModel(),
      context: context,
    );
  }
}
