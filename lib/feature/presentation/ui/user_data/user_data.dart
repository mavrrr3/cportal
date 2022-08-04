import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/widgets/phone_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/user_data/widgets/user_data_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class UserData extends StatefulWidget {
  final String id;
  const UserData({Key? key, required this.id}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  @override
  void initState() {
    super.initState();
    context.read<GetSingleProfileBloc>().add(GetSingleProfileEventImpl(
          widget.id,
          isMyProfile: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

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
            localizedStrings.yourData,
            style: theme.textTheme.header,
          ),
        ),
        body: BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
          builder: (context, state) {
            if (state is GetSingleProfileLoadedState) {
              final ProfileEntity profile = state.profile;

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 33),
                      const PhoneBox(),
                      const SizedBox(height: 24),
                      UserDataRow(
                        normalText: localizedStrings.position,
                        boldText: profile.position,
                      ),
                      const SizedBox(height: 8),
                      UserDataRow(
                        normalText: localizedStrings.department,
                        boldText: profile.department,
                      ),
                      const SizedBox(height: 8),
                      if (profile.birthDayToString != null)
                        UserDataRow(
                          normalText: localizedStrings.birthDay,
                          boldText: profile.birthDayToString!,
                        ),
                      const SizedBox(height: 8),
                      UserDataRow(
                        normalText: localizedStrings.email,
                        boldText: profile.email,
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      Button.factory(
                        context,
                        ButtonEnum.blue,
                        'Сохранить изменения',
                        () {
                          // TODO раелизовать сохранение номера.
                        },
                        const Size(double.infinity, 48),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: PlatformProgressIndicator());
          },
        ),
      ),
    );
  }
}
