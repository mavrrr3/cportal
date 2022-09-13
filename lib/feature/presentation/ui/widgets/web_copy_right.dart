import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebCopyRight extends StatelessWidget {
  const WebCopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      children: [
        if (kIsWeb) ...[
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  height: 2,
                  color: theme.divider,
                ),
                const SizedBox(height: 12),
                Text(
                  '© CompanyName, 2022',
                  style: theme.textTheme.px12.copyWith(
                    color: theme.text?.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
