import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/components/emtpy_page.dart';
import 'package:newsapp2/components/nodata.dart';
import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/comment/comment_viewmodel.dart';
import 'package:newsapp2/utils/capitalize_extension.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../components/custom_text.dart';
import '../../services/comment_services.dart';

class CommentPage extends StatefulWidget {
  final String? newsUrl;
  const CommentPage({super.key, this.newsUrl});

  static DateTime now = DateTime.now();
  static DateTime date = DateTime(now.year, now.month, now.day).toLocal();
  static int epochDate = date.millisecondsSinceEpoch;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    CommentProvider vm = Provider.of<CommentProvider>(context, listen: false);
    vm.getCommentByNews(widget.newsUrl!);
    vm.getUserInfo();
    // vm.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommentProvider vm = Provider.of<CommentProvider>(context);

    if (kDebugMode) {
      print("${vm.userName!} ${vm.userId!}");
    }
    return Scaffold(
        appBar: AppBar(
          title: const CustomText(
            text: 'Yorumlar',
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        body: _buildContent(context, vm),
        bottomSheet: vm.userId!.isEmpty || vm.userName!.isEmpty
            ? const SizedBox()
            : _buildBottomSheet(context, vm));
  }

  _buildContent(context, CommentProvider vm) {
    if (vm.isLaoding) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (vm.commentByNews == null) {
      return const NoDataPage();
    } else if (vm.commentByNews!.isEmpty) {
      return const EmptyPage(
        text:
            'Bu habere henüz yorum yapılmamıştır. Yorum yapmak istiyorsanız üye olup yorum yapabilirsiniz.',
      );
    } else if (vm.commentByNews!.isNotEmpty) {
      return SingleChildScrollView(
        child: Scrollbar(
          child: SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.commentByNews?.length,
                itemBuilder: (context, index) {
                  int date = vm.commentByNews![index].date!;
                  dynamic fromEpoch =
                      DateTime.fromMillisecondsSinceEpoch(date).toLocal();
                  var formattedDate = DateFormat.yMd("tr-TR").format(fromEpoch);
                  if (vm.userId == vm.commentByNews?[index].userId) {
                    return Dismissible(
                        background: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ColorManager.instance.fail),
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.delete_simple,
                                  color: ColorManager.instance.white,
                                  size: Utility.dynamicWidthPixel(30),
                                ),
                                SizedBox(
                                  width: Utility.dynamicWidthPixel(10),
                                ),
                                CustomText(
                                  sizes: Sizes.small,
                                  text: 'Yorumu Sil',
                                  color: ColorManager.instance.white,
                                ),
                              ],
                            )),
                        key: UniqueKey(),
                        confirmDismiss: (direction) async {
                          showCupertinoDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: ((context) => Material(
                                      child: CupertinoAlertDialog(
                                    title: Icon(
                                      CupertinoIcons.delete_simple,
                                      color: ColorManager.instance.fail,
                                      size: Utility.dynamicWidthPixel(30),
                                    ),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height:
                                                Utility.dynamicWidthPixel(30)),
                                        const CustomText(
                                          sizes: Sizes.normal,
                                          text:
                                              'Seçilen Yorumu Silmek İstediğinize Emin misiniz ?',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: Utility.dynamicWidthPixel(18),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        textStyle: TextStyle(
                                            color: ColorManager.instance.fail),
                                        child: const CustomText(
                                          sizes: Sizes.normal,
                                          text: 'İptal',
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: const CustomText(
                                          sizes: Sizes.normal,
                                          text: 'Onayla',
                                          textAlign: TextAlign.center,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(true);
                                          vm
                                              .deleteComment(
                                                  vm.commentByNews![index].sId!)
                                              .then((value) {
                                            if (value != null) {
                                              if (value.message.contains(
                                                  'Comment Deleted')) {
                                                vm.getCommentByNews(
                                                    widget.newsUrl!);

                                                SnackBar snackBar = SnackBar(
                                                    backgroundColor:
                                                        ColorManager
                                                            .instance.success,
                                                    content: const CustomText(
                                                      sizes: Sizes.normal,
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      text:
                                                          'Yorumunuz silinmiştir.',
                                                    ));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ))));
                          return false;
                        },
                        child: _buildCommentItem(vm, index, formattedDate));
                  } else {
                    return _buildCommentItem(vm, index, formattedDate);
                  }
                }),
          ),
        ),
      );
    }
  }

  _buildCommentItem(CommentProvider vm, int index, String formattedDate) {
    return Padding(
      padding: EdgeInsets.all(Utility.dynamicWidthPixel(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: Utility.dynamicWidthPixel(22),
                backgroundImage: const AssetImage('assets/images/auth.png'),
              ),
              SizedBox(width: Utility.dynamicWidthPixel(16)),
              CustomText(
                sizes: Sizes.normal,
                text: "${vm.commentByNews?[index].username?.capitalize()}  • ",
                maxLines: 1,
              ),
              SizedBox(width: Utility.dynamicWidthPixel(6)),
              Flexible(
                child: CustomText(
                  sizes: Sizes.xsmall,
                  text: formattedDate,
                  color: Colors.grey,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: Utility.dynamicWidthPixel(16)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Utility.dynamicWidthPixel(16),
                left: Utility.dynamicWidthPixel(9)),
            child: CustomText(
              sizes: Sizes.normal,
              text: vm.commentByNews?[index].body?.capitalize(),
              maxLines: 4,
            ),
          ),
          /* Padding(
                        padding: EdgeInsets.only(
                            top: Utility.dynamicWidthPixel(16),
                            left: Utility.dynamicWidthPixel(9)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                CupertinoIcons.heart,
                                size: Utility.dynamicWidthPixel(24),
                                color: ColorManager.instance.fail,
                              ),
                            ),
                            SizedBox(width: Utility.dynamicWidthPixel(16)),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                CupertinoIcons.heart_slash,
                                size: Utility.dynamicWidthPixel(24),
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: Utility.dynamicWidthPixel(16)),
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                CupertinoIcons.info,
                                size: Utility.dynamicWidthPixel(24),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ) */
        ],
      ),
    );
  }

  _buildBottomSheet(context, CommentProvider vm) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Utility.dynamicWidthPixel(40),
          left: Utility.dynamicWidthPixel(16),
          right: Utility.dynamicWidthPixel(16)),
      child: TextField(
        controller: vm.textEditingController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
          hintText: 'Yorum Ekle...',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.send_sharp,
              size: Utility.dynamicWidthPixel(28),
            ),
            onPressed: () {
              if (vm.textEditingController.text.isEmpty ||
                  vm.textEditingController.text.length < 5 ||
                  vm.textEditingController.text.length > 300) {
                SnackBar snackBar = SnackBar(
                    backgroundColor: ColorManager.instance.fail,
                    content: const CustomText(
                      sizes: Sizes.normal,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      text: 'Yorumunuz 5 ile 300 karakter arasında olmalıdır.',
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                CommentServices()
                    .addComment(
                        vm.textEditingController.text,
                        CommentPage.epochDate,
                        vm.userName.toString(),
                        vm.userId.toString(),
                        widget.newsUrl!)
                    .then((value) {
                  if (value != null) {
                    vm.getCommentByNews(widget.newsUrl!);
                    SnackBar snackBar = SnackBar(
                        backgroundColor: ColorManager.instance.success,
                        content: const CustomText(
                          sizes: Sizes.normal,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          text: 'Yorumunuz başarıyla eklendi',
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    vm.textEditingController.text = "";
                  } else {
                    SnackBar snackBar = SnackBar(
                        backgroundColor: ColorManager.instance.fail,
                        content: const CustomText(
                          sizes: Sizes.normal,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          text: 'Yorumunuz Eklenemedi.',
                        ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              }
            },
          ),
          contentPadding: EdgeInsets.all(Utility.dynamicWidthPixel(16)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(64),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(64),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(64),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(64),
          ),
        ),
      ),
    );
  }
}
