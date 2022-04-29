import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NewsCardItem extends StatelessWidget {
  final String imgPath;
  final String title;
  final String dateTime;
  final double? width;
  final double? height;
  final double? fontSize;

  const NewsCardItem({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.dateTime,
    this.width,
    this.height,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width ?? 220,
          height: height ?? 106,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: FractionalOffset.topCenter,
              image: ExtendedNetworkImageProvider(
                imgPath,
                cache: true,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                softWrap: true,
                style: theme.textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    dateTime,
                    style: theme.textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
