import 'package:flutter/material.dart';
import 'package:newsapp2/pages/signup/signup_model.dart';

import '../core/init/network/network_manager.dart';
import '../pages/login/login_model.dart';

class AuthServices {
  final BuildContext? context;
  AuthServices({this.context});
  Future<dynamic> login(String username, String password) async {
    return await NetworkManager.instance.post<LoginModel>(
      data: {"username": username, "password": password},
      path: "/user/login",
      model: LoginModel(),
      context: context,
    );
  }

  Future<dynamic> signup(String username, String password, String email,
      String fullname, String phone, String lat, String long) async {
    var geo = {};
    geo["lat"] = lat;
    geo["long"] = long;
    return await NetworkManager.instance.post<SignupModel>(
      data: {
        "username": username,
        "password": password,
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "geometry": geo
      },
      path: "/user/signup",
      model: SignupModel(),
      context: context,
    );
  }
}
