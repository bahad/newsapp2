// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:newsapp2/components/custom_dialog.dart';
import 'package:newsapp2/components/nodata.dart';

import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/pages/favorites/favorites_viewmodel.dart';
import 'package:newsapp2/pages/favorites/widgets/favorites_list_item.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../components/emtpy_page.dart';
import '../../core/init/theme/color_manager.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    FavoritesProvider vm =
        Provider.of<FavoritesProvider>(context, listen: false);
    vm.getUserId();
    vm.getFav();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FavoritesProvider vm = Provider.of<FavoritesProvider>(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: _buildAppBar(),
        body: WillPopScope(
          child: _buildContent(context, vm),
          onWillPop: () async => false,
        ));
  }

  _buildAppBar() {
    return AppBar(
        title: const CustomText(
          text: 'Favoriler',
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black));
  }

  _buildContent(context, FavoritesProvider vm) {
    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (vm.favorite == null) {
      return const Center(child: NoDataPage());
    } else {
      if (vm.favorite!.isEmpty) {
        return const EmptyPage(
          text:
              'Favori Listeniz Boş. Dilediğiniz haberi favori listenize ekleyebilir dilediğiniz zaman okuyabilirsiniz.',
        );
      }
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Utility.dynamicWidthPixel(16)),
          child: SizedBox(
            child: ListView.separated(
                itemCount: vm.favorite!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: ((ctx, index) => SizedBox(
                      height: Utility.dynamicWidthPixel(16),
                    )),
                itemBuilder: ((ctx, index) => Slidable(
                      key: UniqueKey(),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: ((context2) {
                              CustomDialog().showDialog(
                                Image.asset(
                                  'assets/icons/delete.png',
                                  height: Utility.dynamicWidthPixel(53),
                                ),
                                'Seçilen haberi silmek istediğinize emin misiniz ?',
                                () {
                                  vm.deleteFav(
                                      vm.favorite![index].url!, vm.userID);
                                  vm.getFav();

                                  SnackBar snackBar = SnackBar(
                                      backgroundColor:
                                          ColorManager.instance.success,
                                      content: const CustomText(
                                        sizes: Sizes.normal,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        text:
                                            'Seçtiğiniz haber listenizden silinmiştir.',
                                      ));
                                  ScaffoldMessenger.of(ctx)
                                      .showSnackBar(snackBar);
                                },
                                context,
                              );
                            }),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            icon: CupertinoIcons.delete,
                            label: 'Sil',
                          ),
                        ],
                      ),
                      child: FavoritesListItem(
                        title: vm.favorite![index].title.toString(),
                        sources: vm.favorite![index].source.toString(),
                        url: vm.favorite![index].url.toString(),
                        image: vm.favorite![index].image.toString(),
                        time: vm.favorite![index].time.toString(),
                        subtitle: vm.favorite![index].subtitle.toString(),
                      ),
                    ))),
          ),
        ),
      );
    }
  }
}
