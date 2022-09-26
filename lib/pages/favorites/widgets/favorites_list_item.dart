import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_text.dart';
import '../../../core/init/theme/color_manager.dart';
import '../../newsdetail/newsdetail_view.dart';

class FavoritesListItem extends StatelessWidget {
  final String title, sources, url, image, time, subtitle;
  const FavoritesListItem(
      {super.key,
      required this.title,
      required this.sources,
      required this.url,
      required this.image,
      required this.time,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                      title: title,
                      sources: sources,
                      url: url,
                      image: image,
                      time: time,
                      subtitle: subtitle,
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
              image != ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: image,
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
                        text: title),
                    const SizedBox(height: 10),
                    CustomText(
                        sizes: Sizes.small,
                        fontWeight: FontWeight.normal,
                        text: time),
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
                                text: sources),
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
