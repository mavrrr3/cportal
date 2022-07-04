import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/biometric/enroll_biometric_auth_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';

class EnrollFingerPrintScreen extends StatelessWidget {
  const EnrollFingerPrintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return EnrollBiometricAuthScreen(
      title: AppLocalizations.of(context)!.useFaceId,
      biometricType: BiometricType.fingerprint,
      logo: SvgPicture.asset(
        ImageAssets.fingerPrint,
        color: theme.text!.withOpacity(0.05),
        width: 149,
        height: 162,
      ),
    );
  }
}
