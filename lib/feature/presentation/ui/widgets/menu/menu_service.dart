import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_event.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MenuService {
  static void changePage(BuildContext context, int index) {
    context.read<NavigationBarBloc>().add(NavBarChangePageEvent(index: index));

    switch (index) {
      case 0:
        context.pushNamed(NavigationRouteNames.mainPage);
        break;
      case 1:
        context.pushNamed(NavigationRouteNames.news);
        break;
      case 2:
        context.pushNamed(NavigationRouteNames.questions);
        break;
      case 3:
        context.pushNamed(NavigationRouteNames.declarations);
        break;
      case 4:
        context.pushNamed(NavigationRouteNames.contacts);
        break;
      default:
        context.pushNamed(NavigationRouteNames.mainPage);
    }
  }
}
