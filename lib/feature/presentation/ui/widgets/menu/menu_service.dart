import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MenuService {
  static void changePage(BuildContext context, int index) {
    final currentLocation = GoRouter.of(context).location;

    if (currentLocation != _locationByIndex(index)) {
      context
          .read<NavigationBarBloc>()
          .add(NavBarChangePageEvent(index: index));

      switch (index) {
        case 0:
          context.goNamed(NavigationRouteNames.mainPage);
          break;
        case 1:
          context.goNamed(NavigationRouteNames.news);
          break;
        case 2:
          context.goNamed(NavigationRouteNames.questions);
          break;
        case 3:
          context.goNamed(NavigationRouteNames.declarations);
          break;
        case 4:
          context.goNamed(NavigationRouteNames.contacts);
          break;
      }
    }
  }

  static String _locationByIndex(int i) {
    switch (i) {
      case 0:
        return Routes.main;
      case 1:
        return Routes.news;
      case 2:
        return Routes.questions;
      case 3:
        return Routes.declarations;
      case 4:
        return Routes.contacts;
      default:
        return Routes.main;
    }
  }
}
