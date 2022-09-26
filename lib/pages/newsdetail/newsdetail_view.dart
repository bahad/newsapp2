import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/newsdetail/newsdetail_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../components/animated_fab.dart';
import '../../components/custom_text.dart';
import '../favorites/favorites_model.dart';
import '../comment/comment_view.dart';

class NewsDetailPage extends StatefulWidget {
  final String title; // PAYLAŞMAK İÇİN
  final String image; //FAVORİ EKLEMEK İÇİN
  final String subtitle; //FAVORİ EKLEMEK İÇİN
  final String time; //FAVORİ EKLEMEK İÇİN
  final String sources;
  final String url;
  const NewsDetailPage(
      {super.key,
      required this.title,
      required this.sources,
      required this.url,
      required this.image,
      required this.subtitle,
      required this.time});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    NewsDetailProvider vm = Provider.of(context, listen: false);
    vm.getUserId();
    vm.getData(widget.url, widget.sources);
    vm.getFavMatch(widget.url, vm.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewsDetailProvider vm = context.watch<NewsDetailProvider>();
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildFab(context, vm),
      body: _buildContent(context, vm),
    );
  }

  _buildAppBar() {
    return AppBar(
        title: const CustomText(
          text: 'Detaylar',
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black));
  }

  _buildContent(context, NewsDetailProvider vm) {
    Size size = MediaQuery.of(context).size;
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (vm.newsDetail == null) {
      return const Center(child: Text('İnternet Bağlantısı yok'));
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 8,
                    child: CustomText(
                      sizes: Sizes.sliverTitle,
                      text: vm.newsDetail.result?.head,
                      maxLines: 100,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(width: size.width / 1.6),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.020),
              vm.newsDetail.result!.date == null ||
                      vm.newsDetail.result?.date?.length == 0
                  ? const SizedBox()
                  : Column(
                      children: [
                        CustomText(
                          color: Colors.grey,
                          text: vm.newsDetail.result!.date! +
                              " - " +
                              vm.newsDetail.result!.yazar!,
                          maxLines: 10,
                        ),
                        SizedBox(height: size.height * 0.020),
                      ],
                    ),
              FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFe6eef8),
                      border:
                          Border.all(color: ColorManager.instance.iconColor),
                      borderRadius: BorderRadius.circular(3)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CustomText(
                          sizes: Sizes.small,
                          color: ColorManager.instance.iconColor,
                          textAlign: TextAlign.left,
                          text: widget.sources.toString()),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.030),
              vm.newsDetail.result?.image == "" ||
                      vm.newsDetail.result?.image == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.height * 0.210,
                        width: size.width, // 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset('assets/images/news2.webp',
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.210),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.height * 0.210, //150
                        width: size.width, // 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: CachedNetworkImage(
                            imageUrl: vm.newsDetail.result!.image.toString(),
                            errorWidget: (context, url, error) =>
                                const SizedBox(),
                            fit: BoxFit.cover,
                            width: size.width,
                            height: size.height * 0.210),
                      ),
                    ),
              SizedBox(height: size.height * 0.030),
              vm.newsDetail.result!.abstract == null ||
                      vm.newsDetail.result!.abstract!.isEmpty
                  ? const SizedBox()
                  : Column(
                      children: [
                        CustomText(
                          sizes: Sizes.big,
                          fontWeight: FontWeight.w800,
                          text: '${vm.newsDetail.result?.abstract}',
                          maxLines: 100,
                        ),
                        SizedBox(height: size.height * 0.030),
                      ],
                    ),
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: vm.newsDetail.result!.contents!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6),
                      child: CustomText(
                        sizes: Sizes.big,
                        text: vm.newsDetail.result!.contents![index].paragraph!,
                        maxLines: 1000,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  _buildFab(context, NewsDetailProvider vm) {
    return AnimatedFab(
      onPressedShare: () async {
        await FlutterShare.share(
            title: widget.title,
            text: widget.title,
            linkUrl: widget.url.split("^").join("/"),
            chooserTitle: widget.sources);
      },
      onPressedComment: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentPage(
                      newsUrl: widget.url,
                    )));
      },
      onPressedAddFavorites: () async {
        if (vm.isFav || vm.userID.isEmpty) {
        } else {
          var fav = Favorite(
            url: widget.url,
            userId: vm.userID,
            image: widget.image,
            source: widget.sources,
            subtitle: widget.subtitle,
            time: widget.time,
            title: widget.title,
          );
          await vm.dbHelper?.insertFavorite(fav);
        }
      },
    );
  }
}
