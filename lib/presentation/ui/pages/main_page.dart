import 'package:cportal_flutter/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

          return Center(
            child: Text(profile.firstName),
          );
        }

        return const Center(
          child: Text('Пусто'),
        );
      },
    );
  }
}
