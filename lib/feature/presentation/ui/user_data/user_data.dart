import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/widgets/phone_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/widgets/user_data_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(const GetSingleProfileEventImpl(
      'A1B2C3D4E5',
      isMyProfile: true,
    ));
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Swipe(
      onSwipeRight: () => context.goNamed(NavigationRouteNames.profile),
      child: Scaffold(
        backgroundColor: theme.background,
        appBar: AppBar(
          backgroundColor: theme.background,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.goNamed(NavigationRouteNames.profile),
            icon: Icon(
              Icons.arrow_back,
              color: theme.text,
            ),
          ),
          title: Text(
            AppLocalizations.of(context)!.yourData,
            style: theme.textTheme.header,
          ),
        ),
        body: BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
          builder: (context, state) {
            if (state is GetSingleProfileLoadedState) {
              final ProfileEntity profile = state.profile;

              return Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 33),
                    const PhoneBox(),
                    const SizedBox(height: 24),
                    UserDataRow(
                      normalText: AppLocalizations.of(context)!.position,
                      boldText: profile.position,
                    ),
                    const SizedBox(height: 8),
                    UserDataRow(
                      normalText: AppLocalizations.of(context)!.department,
                      boldText: profile.department,
                    ),
                    const SizedBox(height: 8),
                    if (profile.birthDayToString != null)
                      UserDataRow(
                        normalText: AppLocalizations.of(context)!.birthDay,
                        boldText: profile.birthDayToString!,
                      ),
                    const SizedBox(height: 8),
                    UserDataRow(
                      normalText: AppLocalizations.of(context)!.email,
                      boldText: profile.email,
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    Button.factory(
                      context,
                      ButtonEnum.blue,
                      '??????????????????',
                      () {
                        // TODO ?????????????????????? ???????????????????? ????????????.
                      },
                      const Size(double.infinity, 48),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
