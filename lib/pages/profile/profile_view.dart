// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:newsapp2/components/custom_dialog.dart';
import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/login/login_view.dart';
import 'package:newsapp2/pages/profile/profile_viewmodel.dart';
import 'package:newsapp2/pages/profile/update_profile.dart';
import 'package:newsapp2/utils/capitalize_extension.dart';
import 'package:provider/provider.dart';

import '../../components/custom_icon.dart';
import '../../components/custom_text.dart';
import '../../core/init/cache/shared_preferences_config.dart';
import '../navbar/navbar.dart';
import 'widgets/profile_list_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    PreferenceUtils.init();
    String userId = PreferenceUtils.getString("userId");
    String username = PreferenceUtils.getString("username");
    ProfileProvider vm = Provider.of<ProfileProvider>(context, listen: false);

    /* Future.delayed(const Duration(milliseconds: 100), () {
      vm.getUserData(userId);
      vm.getCommentByUser(userId);
    }); */
    vm.getUserData(userId);
    vm.getCommentByUser(userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProfileProvider vm = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: _buildContent(size, vm),
    );
  }

  _buildContent(size, ProfileProvider vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (vm.userModel == null || vm.userModel?.user == null) {
      return const Center(child: LoginPage());
    } else {
      List<IconData> icons = const [
        CupertinoIcons.mail,
        CupertinoIcons.phone,
      ];
      List<TextEditingController> txtController = [
        vm.emailController,
        vm.phoneController,
      ];
      List<String> hints = [
        vm.userModel?.user?.email ?? "Email giriniz.",
        vm.phoneController.text =
            vm.userModel?.user?.phone ?? "Telefon numarası giriniz",
      ];
      vm.emailController.text = vm.userModel?.user?.email ?? "";
      vm.phoneController.text = vm.userModel?.user?.phone ?? "";

      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Utility.dynamicWidthPixel(8)),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhysicalModel(
                    elevation: 18,
                    color: Colors.white,
                    shape: BoxShape.circle,
                    child: Container(
                      padding: EdgeInsets.all(Utility.dynamicWidthPixel(6)),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2.5,
                            color: ColorManager.instance.buttonColor,
                          )),
                      child: CircleAvatar(
                        radius: Utility.dynamicWidthPixel(55),
                        backgroundImage: const NetworkImage(
                            'https://i.pinimg.com/564x/e2/1f/6c/e21f6cc78f5db19ed54595482e582b3f.jpg'),
                        /* child: CustomText(
                                  text: vm.userModel.user!.fullname
                                      .substring(0, 1)
                                      .toUpperCase()), */
                      ),
                    ),
                  ),
                  SizedBox(height: Utility.dynamicWidthPixel(16)),
                  vm.userModel?.user?.fullname != null
                      ? CustomText(
                          sizes: Sizes.big,
                          text:
                              vm.userModel?.user?.fullname?.capitalize() ?? "",
                        )
                      : const SizedBox(),
                  SizedBox(height: Utility.dynamicWidthPixel(3)),
                  vm.userModel?.user?.username != null
                      ? CustomText(
                          sizes: Sizes.normal,
                          text:
                              vm.userModel?.user?.username?.capitalize() ?? "",
                        )
                      : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      vm.userModel!.user!.isBanned!
                          ? Row(
                              children: [
                                Tooltip(
                                  message:
                                      'Bu hesap belirli bir süreliğine askıya alınmıştır.',
                                  child: Chip(
                                      backgroundColor:
                                          ColorManager.instance.fail,
                                      avatar: const CustomIcon(
                                        icon: Icons.account_circle,
                                        color: Colors.white,
                                      ),
                                      label: const CustomText(
                                        color: Colors.white,
                                        sizes: Sizes.normal,
                                        text: 'Yasaklı',
                                      )),
                                )
                              ],
                            )
                          : const SizedBox(),
                      !vm.userModel!.user!.isApproved!
                          ? Row(
                              children: [
                                SizedBox(width: size.width * 0.026),
                                const Tooltip(
                                  message: 'Bu hesap onaylanmamıştır.',
                                  child: Chip(
                                      backgroundColor: Color(0xFF25383C),
                                      avatar: CustomIcon(
                                        icon: Icons.label_off_rounded,
                                        color: Colors.white,
                                      ),
                                      label: CustomText(
                                        color: Colors.white,
                                        sizes: Sizes.normal,
                                        text: 'İnaktif',
                                      )),
                                )
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                  SizedBox(height: size.height * 0.029),
                  //  text: vm.userModel.user!.media!.twitter,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/twitter.svg',
                        height: Utility.dynamicWidthPixel(41),
                      ),
                      SvgPicture.asset(
                        'assets/icons/instagram.svg',
                        height: Utility.dynamicWidthPixel(41),
                      ),
                      SvgPicture.asset(
                        'assets/icons/facebook.svg',
                        height: Utility.dynamicWidthPixel(41),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.029),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding:
                              EdgeInsets.all(Utility.dynamicWidthPixel(16)),
                          child: Center(
                            child: Column(
                              children: [
                                const CustomText(
                                  sizes: Sizes.normal,
                                  text: 'Takipçiler',
                                ),
                                SizedBox(height: Utility.dynamicWidthPixel(10)),
                                CustomText(
                                    sizes: Sizes.normal,
                                    fontWeight: FontWeight.bold,
                                    text: vm.userModel?.user?.followers?.length
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          // color: Colors.grey[200],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.all(Utility.dynamicWidthPixel(16)),
                          child: Center(
                            child: Column(
                              children: [
                                const CustomText(
                                  sizes: Sizes.normal,
                                  text: 'Yorumlar',
                                ),
                                SizedBox(height: Utility.dynamicWidthPixel(10)),
                                CustomText(
                                    sizes: Sizes.normal,
                                    fontWeight: FontWeight.bold,
                                    text: vm.commentModel?.comments != null
                                        ? vm.commentModel?.comments?.length
                                            .toString()
                                        : "")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Utility.dynamicWidthPixel(24)),
                  _buildSettings(context, vm),
                  SizedBox(height: Utility.dynamicWidthPixel(40))
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  _buildSettings(context, ProfileProvider vm) {
    List<ProfileListItem> optionsList = [
      ProfileListItem(
        image: 'assets/icons/edit_profile.svg',
        title: 'Profil Bilgilerini Güncelle',
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => UpdateProfile(
                        email: vm.userModel?.user?.email,
                        fullName: vm.userModel?.user?.fullname,
                        phone: vm.userModel?.user?.phone ?? "",
                        instagram: vm.userModel?.user?.media?.instagram ?? "",
                        twitter: vm.userModel?.user?.media?.twitter ?? "",
                        facebook: vm.userModel?.user?.media?.facebook ?? "",
                      )));
        },
        // subtitle: 'Profiline ait bilgilerini değiştirebilirsin.',
      ),
      const ProfileListItem(
        image: 'assets/icons/theme1.svg',
        title: 'Tema Değiştir',
        //   subtitle: 'Tema Değiştir',
        /* trailing: Switch.adaptive(
          value: themeProvider.themeMode,
          onChanged: (val) {
            themeProvider.toggleTheme(val);
          },
        ), */
      ),
      ProfileListItem(
        image: 'assets/icons/logout.svg',
        title: 'Çıkış Yap',
        onTap: () {
          CustomDialog().showDialog(
            SvgPicture.asset('assets/icons/info.svg'),
            'Çıkış Yapmak İstediğinize Emin misiniz ?',
            () {
              PreferenceUtils.setString("userId", "");
              PreferenceUtils.setString("username", "");
              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavbarPage(),
                  ));
            },
            context,
          );
        },
      ),
    ];
    return SizedBox(
      child: ListView.separated(
        clipBehavior: Clip.antiAlias,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => optionsList[index],
        separatorBuilder: ((context, index) => Divider(
              height: Utility.dynamicWidthPixel(16),
            )),
        itemCount: optionsList.length,
      ),
    );
  }
}
