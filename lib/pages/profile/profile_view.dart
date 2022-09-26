// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/login/login_view.dart';
import 'package:newsapp2/pages/navbar/navbar.dart';
import 'package:newsapp2/pages/profile/profile_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../components/custom_icon.dart';
import '../../components/custom_text.dart';
import '../../core/init/cache/shared_preferences_config.dart';

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
    ProfileProvider vm = Provider.of(context, listen: false);

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
        bottomSheet: vm.userModel == null || vm.userModel.user == null
            ? const SizedBox()
            : _buildBottomSheet(context),
        body: _buildContent(size, vm));
  }

  _buildContent(size, ProfileProvider vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (vm.userModel == null || vm.userModel.user == null) {
      return const Center(child: LoginPage());
    } else {
      List<IconData> icons = const [
        CupertinoIcons.person,
        CupertinoIcons.mail,
        CupertinoIcons.phone,
      ];
      List<String> labels = [
        vm.userModel.user.fullname.toString(),
        vm.userModel.user.email.toString(),
        vm.userModel.user.phone.toString()
      ];
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      vm.userModel.user!.fullname != null
                          ? CircleAvatar(
                              child: CustomText(
                                  text: vm.userModel.user!.fullname
                                      .substring(0, 1)
                                      .toUpperCase()),
                            )
                          : const SizedBox(),
                      SizedBox(width: size.width * 0.042),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            sizes: Sizes.big,
                            fontWeight: FontWeight.bold,
                            text: vm.userModel.user?.username.toString(),
                          ),
                          CustomText(
                            sizes: Sizes.big,
                            text: vm.userModel.user?.email.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      vm.userModel.user?.isBanned!
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
                      !vm.userModel.user?.isApproved!
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
                      Image.asset('assets/icons/twitter.png', height: 36),
                      Image.asset('assets/icons/instagram.png', height: 36),
                      Image.asset('assets/icons/facebook.png', height: 36)
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
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              children: [
                                const CustomText(
                                  sizes: Sizes.normal,
                                  text: 'Takipçiler',
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                    sizes: Sizes.normal,
                                    fontWeight: FontWeight.bold,
                                    text: vm.userModel.user?.followers!.length
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
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              children: [
                                const CustomText(
                                  sizes: Sizes.normal,
                                  text: 'Yorumlar',
                                ),
                                const SizedBox(height: 10),
                                CustomText(
                                  sizes: Sizes.normal,
                                  fontWeight: FontWeight.bold,
                                  text: vm.commentModel?.comments?.length
                                      .toString(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: icons.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.black),
                                    hintText: labels[index],
                                    prefixIcon: CustomIcon(
                                      color: ColorManager
                                          .instance.secondaryIconColor,
                                      icon: icons[index],
                                    ),
                                    suffixIcon: CustomIcon(
                                      color:
                                          ColorManager.instance.disabledColor,
                                      icon: CupertinoIcons.pencil,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ));
                          }))),
                  SizedBox(height: Utility.dynamicWidthPixel(40))
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  _buildBottomSheet(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          style: const ButtonStyle(),
          icon: const CustomIcon(
            icon: Icons.logout,
          ),
          label: const CustomText(
            color: Colors.grey,
            sizes: Sizes.normal,
            text: 'Çıkış Yap',
          ),
          onPressed: () {
            PreferenceUtils.setString("userId", "");
            PreferenceUtils.setString("username", "");
            // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const NavbarPage()));
          },
        ),
      ),
    );
  }
}
