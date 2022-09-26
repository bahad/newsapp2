import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  // GlobalKey<FormState>? formKey;

  LoginProvider() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    // formKey = GlobalKey();
  }
}
