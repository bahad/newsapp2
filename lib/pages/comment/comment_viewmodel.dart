import 'package:flutter/material.dart';
import 'package:newsapp2/core/init/cache/shared_preferences_config.dart';
import 'package:newsapp2/services/comment_services.dart';

import 'comment_model.dart';

class CommentProvider extends ChangeNotifier {
  String? userName;
  String? userId;
  List<Comments>? commentByNews;
  var isLaoding = false;
  TextEditingController textEditingController = TextEditingController();

  Future getCommentByNews(String newsUrl) async {
    isLaoding = true;
    await CommentServices().getCommentByNews(newsUrl).then((value) {
      commentByNews = value.comments;
      isLaoding = false;
    });
    notifyListeners();
  }

  getUserInfo() {
    PreferenceUtils.init();
    userName = PreferenceUtils.getString("username");
    userId = PreferenceUtils.getString("userId");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /*CommentProvider() {
    getUserInfo();
  } */

  Future addComment(String body, num date, String username, String userId,
      String newsUrl) async {
    return CommentServices().addComment(body, date, username, userId, newsUrl);
  }

  Future deleteComment(String commentID) async {
    return CommentServices().deleteComment(commentID);
  }
}
