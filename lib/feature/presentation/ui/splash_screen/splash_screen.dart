import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/news_bloc/fetch_news_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/questions_bloc/fetch_questions_bloc.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // _fetchContent(context);

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final nextScreen =
              state is HasAuthCredentials ? NavigationRouteNames.login : NavigationRouteNames.connectingCode;

          context.goNamed(nextScreen);
        },
        child: const SplashWidget.mobile(),
      ),
    );
  }

  // void _fetchContent(BuildContext context) {
  //   context
  //     ..watch<FetchNewsBloc>().add(const FetchAllNewsEvent())
  //     ..watch<FetchQuestionsBloc>().add(const FetchQaustionsEvent())
  //     ..watch<ContactsBloc>().add(const FetchContactsEvent(isFirstFetch: true))
  //     ..watch<FilterContactsBloc>().add(FetchFiltersEvent());
  // }
}
