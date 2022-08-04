import 'package:cportal_flutter/common/constants/uri_schemes.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:flutter/material.dart';
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
        height: 46,
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light ? theme.background : theme.background?.withOpacity(0.34),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.phone,
              size: 26,
              color: theme.textLight,
            ),
            Text(
              phone,
              style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 40),
          ],
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
