// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp2/components/custom_button.dart';
import 'package:newsapp2/components/custom_textfield.dart';

import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/services/user_services.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../core/init/theme/color_manager.dart';
import '../../utils/phone_formatter.dart';
import 'profile_viewmodel.dart';

class UpdateProfile extends StatefulWidget {
  final String? email, fullName, phone, instagram, twitter, facebook;
  const UpdateProfile(
      {super.key,
      this.email,
      this.fullName,
      this.phone,
      this.instagram,
      this.twitter,
      this.facebook});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    ProfileProvider vm = Provider.of<ProfileProvider>(context, listen: false);
    vm.editEmailController.text = widget.email ?? "";
    vm.editFullNameController.text = widget.fullName ?? "";
    vm.editPhoneController.text = widget.phone ?? "";
    vm.editInstagramController.text = widget.instagram ?? "";
    vm.editTwitterController.text = widget.twitter ?? "";
    vm.editFacebookController.text = widget.facebook ?? "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileProvider vm = Provider.of<ProfileProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(size, vm),
    );
  }

  _buildAppBar() {
    return AppBar(
        title: const CustomText(
          text: 'Bilgilerini Güncelle',
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black));
  }

  _buildContent(Size size, ProfileProvider vm) {
    return Padding(
      padding: EdgeInsets.all(
          Utility.dynamicWidthPixel(Utility.dynamicWidthPixel(16))),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              /*  Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.instance.infoContainer,
                  borderRadius: ApplicationConstants.borderRadius,
                ),
                child: Padding(
                    padding: EdgeInsets.all(Utility.dynamicWidthPixel(12)),
                    child: const CustomText(
                      sizes: Sizes.normal,
                      text: 'Kişisel Bilgiler',
                    )),
              ), */
              CustomTextField(
                  controller: vm.editEmailController,
                  topPadding: size.height * 0.04,
                  hintText: 'Email',
                  isSearchable: false,
                  prefixIcon: Icon(
                    CupertinoIcons.mail,
                    size: Utility.dynamicWidthPixel(25),
                  ),
                  onChanged: (val) {},
                  validator: (String? value) {
                    if (value!.length < 9 || !value.contains("@")) {
                      return 'Lütfen geçerli email giriniz';
                    } else {
                      return null;
                    }
                  }),
              CustomTextField(
                controller: vm.editFullNameController,
                topPadding: size.height * 0.04,
                hintText: 'Ad Soyad',
                isSearchable: false,
                prefixIcon: Icon(
                  CupertinoIcons.person,
                  size: Utility.dynamicWidthPixel(25),
                ),
                onChanged: (val) {},
                validator: (String? value) {
                  if (value!.length < 4 || value.length > 30) {
                    return 'Lütfen geçerli bir isim giriniz';
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextField(
                controller: vm.editPhoneController,
                topPadding: size.height * 0.04,
                hintText: 'Telefon',
                isSearchable: false,
                prefixIcon: Icon(
                  CupertinoIcons.phone,
                  size: Utility.dynamicWidthPixel(25),
                ),
                onChanged: (val) {},
                validator: ((p0) => null),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  PhoneNumberFormatter(),
                  LengthLimitingTextInputFormatter(17),
                ],
              ),
              CustomTextField(
                controller: vm.editInstagramController,
                topPadding: size.height * 0.04,
                hintText: 'İnstagram Linki',
                isSearchable: false,
                onChanged: (val) {},
                prefixIcon: SvgPicture.asset(
                  'assets/icons/instagram.svg',
                  height: Utility.dynamicWidthPixel(31),
                  fit: BoxFit.fitWidth,
                ),
                validator: ((p0) => null),
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                controller: vm.editTwitterController,
                topPadding: size.height * 0.04,
                hintText: 'Twitter Linki',
                isSearchable: false,
                onChanged: (val) {},
                prefixIcon: SvgPicture.asset(
                  'assets/icons/twitter.svg',
                  height: Utility.dynamicWidthPixel(31),
                  fit: BoxFit.fitWidth,
                ),
                validator: ((p0) => null),
                keyboardType: TextInputType.text,
              ),
              CustomTextField(
                controller: vm.editFacebookController,
                topPadding: size.height * 0.04,
                hintText: 'Facebook Linki',
                isSearchable: false,
                onChanged: (val) {},
                prefixIcon: SvgPicture.asset(
                  'assets/icons/facebook.svg',
                  height: Utility.dynamicWidthPixel(31),
                  fit: BoxFit.fitWidth,
                ),
                validator: ((p0) => null),
                keyboardType: TextInputType.text,
              ),
              CustomButton(
                topPadding: size.height * 0.05,
                label: 'Onayla',
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                  } else {
                    UserServices()
                        .updateUserData(
                      vm.userModel!.user!.id.toString(),
                      vm.editEmailController.text,
                      vm.editFullNameController.text,
                      vm.editPhoneController.text,
                      vm.editInstagramController.text,
                      vm.editTwitterController.text,
                      vm.editFacebookController.text,
                    )
                        .then((value) {
                      if (value != null) {
                        if (kDebugMode) {
                          print("SIGN UP MESSAGE: ${value.message}");
                        }
                        if (value.message.contains('User Updated')) {
                          SnackBar snackBar = SnackBar(
                              backgroundColor: ColorManager.instance.success,
                              content: CustomText(
                                sizes: Sizes.small,
                                color: ColorManager.instance.successText,
                                text:
                                    'Tebrikler! Profil Bilgileriniz Güncellenmiştir.',
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          vm.getUserData(vm.userModel!.user!.id!);
                          Navigator.of(context).pop();
                        } else {
                          SnackBar snackBar = SnackBar(
                              backgroundColor: ColorManager.instance.fail,
                              content: CustomText(
                                textAlign: TextAlign.center,
                                sizes: Sizes.small,
                                color: ColorManager.instance.failText,
                                text: value.message ?? "Hatalı İşlem.",
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        SnackBar snackBar = SnackBar(
                            backgroundColor: ColorManager.instance.fail,
                            content: CustomText(
                              sizes: Sizes.small,
                              color: ColorManager.instance.failText,
                              text: 'Başarısız Kayıt',
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
