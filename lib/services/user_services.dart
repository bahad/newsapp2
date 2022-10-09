import 'package:flutter/material.dart';
import 'package:newsapp2/pages/profile/user_model.dart';
import 'package:newsapp2/pages/signup/signup_model.dart';

import '../core/init/network/network_manager.dart';

class UserServices {
  final BuildContext? context;
  UserServices({this.context});

  Future<dynamic> getUserByID(String userID) async {
    return await NetworkManager.instance.get<UserModel>(
      path: "/user/$userID",
      model: UserModel(),
      context: context,
    );
  }

  Future<dynamic> updateUserData(
    String userID,
    String email,
    String fullname,
    String phone,
    String instagram,
    String twitter,
    String facebook,
  ) async {
    return await NetworkManager.instance.put<SignupModel>(
      data: {
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "media": {
          'instagram': instagram,
          'twitter': twitter,
          'facebook': facebook,
        }
      },
      path: "/user/$userID",
      model: SignupModel(),
      context: context,
    );
  }
}
