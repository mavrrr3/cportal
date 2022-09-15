import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/new_employee_bloc/fetch_new_employee_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class OnBoardingWelcome extends StatelessWidget {
  const OnBoardingWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.cardColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                const SizedBox(height: 87),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizedStrings.welcome,
                          style: theme.textTheme.header.copyWith(
                            height: 1.2857,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizedStrings.findImportantInformation,
                          style: theme.textTheme.px16.copyWith(
                            height: 1.5,
                            leadingDistribution: TextLeadingDistribution.even,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<FetchNewEmployeeBloc, FetchNewEmployeeState>(
              builder: (context, state) {
            if (state is NewEmployeeLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Button.factory(
                    context,
                    type: ButtonEnum.filled,
                    text: AppLocalizations.of(context)!.forward,
                    onTap: () {
                      GoRouter.of(context).pushNamed(
                        NavigationRouteNames.onboarding,
                        extra: state.slides,
                      );
                    },
                    size: const Size(double.infinity, 48),
                  ),
                ),
              );
            }

            return const Loader();
          }),
        ],
      ),
    );
  }
}
