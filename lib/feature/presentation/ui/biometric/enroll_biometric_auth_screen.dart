import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/biometric_bloc/biometric_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_code_bloc/connecting_code_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

class EnrollBiometricAuthScreen extends StatelessWidget {
  final String title;
  final Widget logo;
  final BiometricType biometricType;

  const EnrollBiometricAuthScreen({
    Key? key,
    required this.title,
    required this.logo,
    required this.biometricType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return BlocConsumer<BiometricBloc, BiometricState>(
      listener: (context, state) {
        if (state is BiometricSuccessfullyEnrolled) {
          _logInWithUser(context);
        }
      },
      builder: (context, state) {
        return AuthMobileLayout(
          child: Column(
            children: [
              SizedBox(
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.header,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizedStrings.doFingerPrintNotInputPin,
                      style: theme.textTheme.px14.copyWith(height: 1.71),
                    ),
                  ],
                ),
              ),
              Expanded(child: logo),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(142, 48),
                      backgroundColor: theme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => context.read<BiometricBloc>().add(
                          EnrollBiometricAuth(
                            localizedStrings.logInToContinue,
                            biometricType,
                          ),
                        ),
                    child: Text(
                      localizedStrings.yes,
                      style: theme.textTheme.px16Bold.copyWith(
                        color: theme.brightness == Brightness.light
                            ? theme.white
                            : theme.text,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.primary,
                      fixedSize: const Size(142, 48),
                      side: BorderSide(
                        width: 2,
                        color: theme.primary!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _logInWithUser(context),
                    child: Text(
                      localizedStrings.noThanks,
                      style: theme.textTheme.px16Bold.copyWith(
                        color: theme.primary,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _logInWithUser(BuildContext context) {
    final connectingCodeState = context.read<ConnectingCodeBloc>().state;
    if (connectingCodeState is AuthenticatedWithConnectingCode) {
      context.read<AuthBloc>().add(LogInWithUser(connectingCodeState.user));
      context.goNamed(NavigationRouteNames.mainPage);
    }
  }
}
