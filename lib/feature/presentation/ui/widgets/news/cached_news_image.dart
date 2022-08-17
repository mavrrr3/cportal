import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CachedNewsImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imgUrl;
  const CachedNewsImage({
    Key? key,
    this.width,
    this.height,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return ExtendedImage.network(
      fit: BoxFit.cover,
      shape: BoxShape.rectangle,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      width: width ?? 220,
      height: height ?? 106,
      imgUrl,
      handleLoadingProgress: true,
      clearMemoryCacheIfFailed: false,
      clearMemoryCacheWhenDispose: false,
      cache: true,
      imageCacheName: imgUrl,
      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.loading) {
          return Container(
            color: theme.background,
          );
        }

        return null;
      },
    );
  }
}
