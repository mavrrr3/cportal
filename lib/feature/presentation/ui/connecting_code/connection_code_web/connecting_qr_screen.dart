import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/connecting_qr_bloc/connecting_qr_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/auth_desktop_layout.dart';
import 'package:cportal_flutter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConnectingQrScreen extends StatelessWidget {
  const ConnectingQrScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocProvider<ConnectingQrBloc>(
      create: (ctx) => sl<ConnectingQrBloc>(),
      child: AuthDesktopLayout(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<ConnectingQrBloc, ConnectingQrState>(
                builder: (context, state) {
                  return QrImage(
                    data: state.qrData,
                    size: 206,
                    backgroundColor: theme.background!,
                  );
                },
                listener: (context, state) {
                  if (state is ConnectingQrSuccessAuth) {
                    context.read<AuthBloc>().add(LogInWithUser(state.user));
                    context.goNamed(NavigationRouteNames.createPin);
                  }
                },
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.scan_qr_by_phone,
                style: theme.textTheme.px32,
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.qr_code_connect_descript,
                style: theme.textTheme.px22,
              ),
              const SizedBox(height: 96),
              GestureDetector(
                onTap: context.pop,
                child: Text(
                  AppLocalizations.of(context)!.enter_by_connecting_code,
                  style: theme.textTheme.px16.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
