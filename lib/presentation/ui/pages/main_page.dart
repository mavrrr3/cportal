import 'package:cportal_flutter/domain/entities/user_entity.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_user_bloc/get_single_user_bloc.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_user_bloc/get_single_user_event.dart';
import 'package:cportal_flutter/presentation/bloc/user_bloc/get_single_user_bloc/get_single_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late UserEntity user;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetSingleUserBloc>(
      context,
      listen: false,
    ).add(const GetSingleUserEventImpl('id'));

    return BlocBuilder<GetSingleUserBloc, GetSingleUserState>(
      builder: (context, state) {
        if (state is GetSingleUserLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is GetSingleUserLoadedState) {
          user = state.user;

          return Center(
            child: Text(user.username),
          );
        }

        return const Center(
          child: Text('Пусто'),
        );
      },
    );
  }
}
