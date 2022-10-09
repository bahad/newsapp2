import 'package:flutter/material.dart';
import 'package:newsapp2/pages/profile/user_model.dart';
import 'package:newsapp2/services/comment_services.dart';
import 'package:newsapp2/services/user_services.dart';

class ProfileProvider extends ChangeNotifier {
  dynamic commentModel;
  UserModel? userModel;
  bool isLoading = false;
  //PROFİLE
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // PROFILE-EDIT
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editPhoneController = TextEditingController();
  TextEditingController editFullNameController = TextEditingController();
  TextEditingController editInstagramController = TextEditingController();
  TextEditingController editTwitterController = TextEditingController();
  TextEditingController editFacebookController = TextEditingController();

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

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    editEmailController.dispose();
    editPhoneController.dispose();
    editFullNameController.dispose();
    editInstagramController.dispose();
    editTwitterController.dispose();
    editFacebookController.dispose();
    super.dispose();
  }
}
