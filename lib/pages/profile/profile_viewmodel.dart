import 'package:flutter/foundation.dart';
import 'package:newsapp2/services/comment_services.dart';
import 'package:newsapp2/services/user_services.dart';

class ProfileProvider extends ChangeNotifier {
  dynamic commentModel;
  dynamic userModel;
  bool isLoading = false;

  Future getUserData(String userID) async {
    isLoading = true;
    userModel = await UserServices().getUserByID(userID);
    isLoading = false;
    notifyListeners();
  }

  Future getCommentByUser(String userID) async {
    commentModel = await CommentServices().getCommentByUser(userID);
    notifyListeners();
  }
}
