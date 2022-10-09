import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/login/login_viewmodel.dart';
import 'package:newsapp2/services/auth_services.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../core/init/cache/shared_preferences_config.dart';
import '../navbar/navbar.dart';
import '../signup/signup_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this);
    // ignore: unused_local_variable
    LoginProvider vm = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginProvider vm = Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const CustomText(
            sizes: Sizes.normal,
            text: 'Giriş Yap',
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: SingleChildScrollView(
            child: Form(
              // key: vm.formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/lottie_login.json',
                        height: size.height * 0.21,
                        controller: animationController),
                    SizedBox(height: size.height * 0.05),
                    const CustomText(
                      sizes: Sizes.normal,
                      text:
                          'Uygulamaya girebilmek için kullanıcı adı ve şifrenizle giriş yapın',
                      textAlign: TextAlign.center,
                    ),
                    CustomTextField(
                        topPadding: size.height * 0.05,
                        hintText: 'Kullanıcı Adı',
                        labelText: 'Kullanıcı Adı',
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        prefixIcon: const Icon(Icons.person),
                        readonly: false,
                        controller: vm.usernameController,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 4 || value.length > 12) {
                            return 'Kullanıcı adı 4 ile 12 karakter arası olmalıdır.';
                          } else {
                            return null;
                          }
                        }),
                    CustomTextField(
                        topPadding: 15,
                        hintText: 'Şifre',
                        labelText: '****',
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock),
                        readonly: false,
                        controller: vm.passwordController,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 4 || value.length > 12) {
                            return 'Şifreniz 4 ile 12 karakter arası olmalıdır.';
                          } else {
                            return null;
                          }
                        }),
                    CustomButton(
                      topPadding: size.height * 0.05,
                      label: 'Onayla',
                      onPressed: () {
                        AuthServices()
                            .login(vm.usernameController!.text,
                                vm.passwordController!.text)
                            .then((value) {
                          if (value != null) {
                            if (kDebugMode) {
                              print("Login VALUE: ${value.message}");
                            }
                            if (value.message
                                .contains("You have logged in successfully")) {
                              PreferenceUtils.setString(
                                  "username", value.user!.username.toString());
                              PreferenceUtils.setString(
                                  "userId", value.user!.userId.toString());
                              animationController
                                ..duration = const Duration(seconds: 2)
                                ..forward();
                              SnackBar snackBar = SnackBar(
                                  backgroundColor:
                                      ColorManager.instance.success,
                                  content: CustomText(
                                    text: 'Tebrikler ! Giriş işlemi başarılı.',
                                    sizes: Sizes.normal,
                                    color: ColorManager.instance.successText,
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Future.delayed(const Duration(milliseconds: 2100),
                                  () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NavbarPage()));
                              });
                            } else {
                              SnackBar snackBar = SnackBar(
                                  backgroundColor: ColorManager.instance.fail,
                                  content: CustomText(
                                    textAlign: TextAlign.center,
                                    sizes: Sizes.small,
                                    text: "Kullanıcı adı veya şifre hatalı",
                                    color: ColorManager.instance.failText,
                                  ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Future.delayed(
                                  const Duration(milliseconds: 2100));
                            }
                          } else {
                            SnackBar snackBar = const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Giriş işlemi başarısız'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      },
                    ),
                    TextButton(
                      child: const CustomText(
                        sizes: Sizes.small,
                        text: 'Hesabınız yok mu ? Hemen kaydolun.',
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
