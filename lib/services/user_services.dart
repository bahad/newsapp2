import 'package:flutter/material.dart';
import 'package:newsapp2/pages/profile/user_model.dart';

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
}
