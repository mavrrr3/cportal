import 'package:cportal_flutter/common/app_colors.dart';
import 'package:cportal_flutter/common/theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile/widgets/avatar_and_userinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileEntity profile;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(const GetSingleProfileEventImpl('A1B2C3D4E5'));

    return BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
      builder: (context, state) {
        if (state is GetSingleProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetSingleProfileLoadedState) {
          profile = state.profile;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: const Icon(
                Icons.close,
                color: AppColors.kLightTextColor,
              ),
              title: Text(
                AppLocalizations.of(context)!.profile,
                style: kMainTextRusso.copyWith(fontSize: 28),
              ),
            ),
            body: Column(
              children: [
                AvatarAndUserInfo(profile: profile),
              ],
            ),
          );
        }

        return const Center(
          child: Text('Пусто'),
        );
      },
    );
  }
}
