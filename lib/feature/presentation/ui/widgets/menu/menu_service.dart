import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MenuService {
  static void changePage(BuildContext context, int index) {
    final currentLocation = GoRouter.of(context).location.substring(1);

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
        return NavigationRouteNames.mainPage;
      case 1:
        return NavigationRouteNames.news;
      case 2:
        return NavigationRouteNames.questions;
      case 3:
        return NavigationRouteNames.declarations;
      case 4:
        return NavigationRouteNames.contacts;
      default:
        return NavigationRouteNames.mainPage;
    }
  }
}
