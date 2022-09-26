import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp2/core/init/theme/color_manager.dart';
import 'package:newsapp2/pages/newsdetail/newsdetail_view.dart';

import '../pages/home/news_model.dart';
import 'custom_text.dart';

class ListNewsItem extends StatelessWidget {
  final Result news;
  final BuildContext context;
  const ListNewsItem({Key? key, required this.news, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                      title: news.title!,
                      sources: news.source!,
                      url: news.url!,
                      image: news.image!,
                      time: news.time!,
                      subtitle: news.subtitle!,
                    )));
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              news.image != ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: news.image.toString(),
                        height: size.width * 0.420,
                        width: size.width * 0.360,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.width * 0.420,
                        width: size.width * 0.360, // 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/images/news2.webp',
                          fit: BoxFit.fitHeight,
                          width: size.width * 0.373,
                          height: size.height * 0.220,
                        ),
                      ),
                    ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      sizes: Sizes.normal,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start,
                      text: news.title.toString(),
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      sizes: Sizes.small,
                      fontWeight: FontWeight.normal,
                      text: news.time.toString(),
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFe6eef8),
                            border: Border.all(
                                color: ColorManager.instance.iconColor),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CustomText(
                                sizes: Sizes.small,
                                color: ColorManager.instance.iconColor,
                                textAlign: TextAlign.left,
                                text: news.source.toString()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
