// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/services/auth_services.dart';
import 'package:newsapp2/utils/phone_formatter.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../core/base/base_state.dart';
import '../../core/init/cache/shared_preferences_config.dart';
import '../navbar/navbar.dart';
import 'signup_viewmodel.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    PreferenceUtils.init();
    SignupProvider signupProvider =
        Provider.of<SignupProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SignupProvider vm = Provider.of<SignupProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            sizes: Sizes.normal,
            text: 'Kayıt Ol',
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Scrollbar(
          interactive: true,
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/auth.png',
                      height: size.height * 0.10,
                    ),
                    SizedBox(height: size.height * 0.03),
                    const CustomText(
                      sizes: Sizes.normal,
                      text:
                          'Yorum yapmak veya haber oluşturmak için hesap oluşturun.',
                      textAlign: TextAlign.center,
                    ),
                    CustomTextField(
                        controller: vm.usernameController,
                        topPadding: size.height * 0.02,
                        hintText: 'Kullanıcı Adı',
                        labelText: 'Kullanıcı Adı',
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        prefixIcon: Icon(
                          Icons.person,
                          size: Utility.dynamicWidthPixel(25),
                        ),
                        readonly: false,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 4 || value.length > 12) {
                            return 'Kullanıcı adı 4 ile 12 karakter arası olmalıdır.';
                          } else {
                            return null;
                          }
                        }),
                    CustomTextField(
                        controller: vm.emailController,
                        topPadding: size.height * 0.02,
                        hintText: 'Email',
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          size: Utility.dynamicWidthPixel(25),
                        ),
                        readonly: false,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 9 || !value.contains("@")) {
                            return 'Lütfen geçerli email giriniz';
                          } else {
                            return null;
                          }
                        }),
                    CustomTextField(
                        controller: vm.fullnameController,
                        topPadding: size.height * 0.02,
                        hintText: 'İsim, Soyisim',
                        labelText: 'İsim, Soyisim',
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        prefixIcon: Icon(
                          CupertinoIcons.person,
                          size: Utility.dynamicWidthPixel(25),
                        ),
                        readonly: false,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 4 || value.length > 30) {
                            return 'Lütfen geçerli bir isim giriniz';
                          } else {
                            return null;
                          }
                        }),
                    CustomTextField(
                        controller: vm.phoneController,
                        topPadding: size.height * 0.02,
                        hintText: '(+90) 534 *******',
                        labelText: 'Telefon',
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          PhoneNumberFormatter(),
                          LengthLimitingTextInputFormatter(17),
                        ],
                        obscureText: false,
                        prefixIcon: Icon(
                          CupertinoIcons.phone,
                          size: Utility.dynamicWidthPixel(25),
                        ),
                        readonly: false,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 14 || value.length > 17) {
                            return 'Lütfen geçerli bir telefon numarası giriniz';
                          } else {
                            return null;
                          }
                        }),
                    CustomTextField(
                        controller: vm.passwordController,
                        topPadding: size.height * 0.02,
                        hintText: 'Şifre',
                        labelText: '****',
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: Utility.dynamicWidthPixel(25),
                        ),
                        readonly: false,
                        isSearchable: false,
                        validator: (String? value) {
                          if (value!.length < 4 || value.length > 12) {
                            return 'Şifreniz 4 ile 12 karakter arası olmalıdır.';
                          } else {
                            return null;
                          }
                        }),
                    CustomButton(
                        topPadding: size.height * 0.04,
                        label: 'Onayla',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                          } else {
                            AuthServices()
                                .signup(
                                    vm.usernameController.text,
                                    vm.passwordController.text,
                                    vm.emailController.text,
                                    vm.fullnameController.text,
                                    vm.phoneController.text,
                                    vm.lat!,
                                    vm.long!)
                                .then((value) {
                              if (value != null) {
                                if (kDebugMode) {
                                  print("SIGN UP MESSAGE: ${value.message}");
                                }
                                if (value.message.contains('user created')) {
                                  SnackBar snackBar = SnackBar(
                                      backgroundColor:
                                          ColorManager.instance.success,
                                      content: CustomText(
                                        sizes: Sizes.small,
                                        color:
                                            ColorManager.instance.successText,
                                        text: 'Tebrikler! Kaydınız başarılı.',
                                      ));
                                  PreferenceUtils.setString("username",
                                      value.user.username.toString());
                                  PreferenceUtils.setString(
                                      "userId", value.user.userId.toString());
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Future.delayed(
                                      const Duration(milliseconds: 2100), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NavbarPage()));
                                  });
                                } else {
                                  SnackBar snackBar = SnackBar(
                                      backgroundColor:
                                          ColorManager.instance.fail,
                                      content: CustomText(
                                        textAlign: TextAlign.center,
                                        sizes: Sizes.small,
                                        color: ColorManager.instance.failText,
                                        text: value.message ?? "Hatalı İşlem.",
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                SnackBar snackBar = SnackBar(
                                    backgroundColor: ColorManager.instance.fail,
                                    content: CustomText(
                                      sizes: Sizes.small,
                                      color: ColorManager.instance.failText,
                                      text: 'Başarısız Kayıt',
                                    ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
