import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/components/no_internet.dart';
import 'package:newsapp2/core/base/base_state.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/home/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text.dart';
import '../../components/custom_textfield.dart';
import '../../components/list_news_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider vm = context.watch<HomeProvider>();
    return Scaffold(
      floatingActionButton: _buildFab(vm),
      body: _buildContent(context, vm),
    );
  }

  _buildContent(BuildContext context, HomeProvider vm) {
    return SingleChildScrollView(
      // physics: const NeverScrollableScrollPhysics(),
      controller: vm.scrollController,
      child: Padding(
        padding: EdgeInsets.all(Utility.dynamicWidthPixel(16)),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (vm.isSearching) {
                  vm.startSearch(context);
                }
              },
              child: CustomTextField(
                controller: vm.searchController,
                obscureText: false,
                hintText: 'Haberlerde arayın...',
                prefixIcon: const Icon(Icons.search),
                topPadding: Utility.dynamicWidthPixel(10),
                readonly: false,
                keyboardType: TextInputType.text,
                labelText: '',
                isSearchable: true,
                validator: (value) {
                  return null;
                },
                onChanged: vm.onSearchTextChanged,
              ),
            ),
            SizedBox(height: Utility.dynamicWidthPixel(10)),
            _buildCategoryList(vm),
            buildCategories(context, vm)
          ],
        ),
      ),
    );
  }

  buildCategories(context, HomeProvider vm) {
    if (vm.searchResult!.isNotEmpty && vm.searchController.text.isNotEmpty) {
      return _buildSearch(vm);
    }

    if (vm.selectedCategoryIndex == 0) {
      return _buildSondakika(vm);
    } else if (vm.selectedCategoryIndex == 1) {
      return _buildGundem(vm);
    } else if (vm.selectedCategoryIndex == 2) {
      return _buildEkonomi(vm);
    } else if (vm.selectedCategoryIndex == 3) {
      return _buildDunya(vm);
    } else {
      return const SizedBox();
    }
  }

  _buildCategoryList(HomeProvider vm) {
    return SizedBox(
      height: Utility.dynamicWidthPixel(80),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: vm.categoryTitles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => vm.updateCategoryIndex(index),
              child: Padding(
                padding: EdgeInsets.all(Utility.dynamicWidthPixel(13)),
                child: Column(
                  children: [
                    CustomText(
                      sizes: Sizes.normal,
                      text: vm.categoryTitles[index],
                      color: vm.selectedCategoryIndex == index
                          ? Colors.black
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                      height: Utility.dynamicWidthPixel(10),
                      width: Utility.dynamicWidthPixel(10),
                      decoration: BoxDecoration(
                          color: vm.selectedCategoryIndex == index
                              ? ColorManager.instance.buttonColor
                              : Colors.white38,
                          borderRadius: BorderRadius.circular(30)),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  _buildSearch(HomeProvider vm) {
    return SizedBox(
      child: Scrollbar(
        radius: const Radius.circular(10),
        interactive: true,
        thickness: 10,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ListView.builder(
          itemCount: vm.searchResult?.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListNewsItem(
                news: vm.searchResult?[index], context: context);
          },
        ),
      ),
    );
  }

  _buildSondakika(HomeProvider vm) {
    if (vm.isSondakikaLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    if (vm.sonDakikaArr == null) {
      return const NoInternet();
    }
    return SizedBox(
      child: ListView.builder(
        itemCount: vm.sonDakikaArr?.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListNewsItem(
            news: vm.sonDakikaArr![index],
            context: context,
          );
        },
      ),
    );
  }

  _buildGundem(HomeProvider vm) {
    if (vm.isGundemLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (vm.gundemArr == null) {
      return const Center(
        child: NoInternet(),
      );
    }
    return SizedBox(
      child: Scrollbar(
        radius: const Radius.circular(10),
        interactive: true,
        thickness: 10,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ListView.builder(
          itemCount: vm.gundemArr?.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListNewsItem(
              news: vm.gundemArr![index],
              context: context,
            );
          },
        ),
      ),
    );
  }

  _buildEkonomi(HomeProvider vm) {
    if (vm.isEkonomiLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (vm.ekonomiArr == null) {
      return const Center(
        child: NoInternet(),
      );
    }
    return SizedBox(
      child: Scrollbar(
        radius: const Radius.circular(10),
        interactive: true,
        thickness: 10,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ListView.builder(
          itemCount: vm.ekonomiArr?.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListNewsItem(
              news: vm.ekonomiArr![index],
              context: context,
            );
          },
        ),
      ),
    );
  }

  _buildDunya(HomeProvider vm) {
    if (vm.isDunyaLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (vm.dunyaArr == null) {
      return const Center(
        child: NoInternet(),
      );
    }
    return SizedBox(
      child: Scrollbar(
        radius: const Radius.circular(10),
        interactive: true,
        thickness: 10,
        scrollbarOrientation: ScrollbarOrientation.right,
        child: ListView.builder(
          itemCount: vm.dunyaArr?.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListNewsItem(
              news: vm.dunyaArr![index],
              context: context,
            );
          },
        ),
      ),
    );
  }

  _buildFab(HomeProvider vm) {
    return FloatingActionButton(
      backgroundColor: ColorManager.instance.buttonColor,
      child: const Icon(
        CupertinoIcons.arrow_up,
        color: Colors.white,
      ),
      onPressed: () {
        vm.scrollController.animateTo(
          vm.scrollController.position.minScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      },
    );
  }
}
