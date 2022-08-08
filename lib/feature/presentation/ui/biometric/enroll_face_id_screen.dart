import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/biometric/enroll_biometric_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

class EnrollFaceIdScreen extends StatelessWidget {
  const EnrollFaceIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return EnrollBiometricAuthScreen(
      title: AppLocalizations.of(context)!.useFaceId,
      biometricType: BiometricType.face,
      logo: SvgPicture.asset(
        ImageAssets.faceId,
        color: theme.text!.withOpacity(0.05),
        width: 192,
        height: 192,
      ),
    );
  }
}
