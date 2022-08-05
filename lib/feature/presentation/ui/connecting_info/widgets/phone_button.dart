import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/constants/uri_schemes.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    const phone = '+7 495 487 34 66';

    return GestureDetector(
      onTap: () => _launchUrl(phone),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light ? theme.background : theme.background?.withOpacity(0.34),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 8,
                child: SvgPicture.asset(
                  ImageAssets.elevatedPhone,
                  color: theme.text,
                ),
              ),
              Text(
                phone,
                // TODO change textStyle
                style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String phone) async {
    final uri = Uri(
      scheme: UriSchemes.tel,
      path: '+${FormatterUtil.pfoneWithoutMask(phone: phone)}',
    );
    await launchUrl(uri);
  }
}
