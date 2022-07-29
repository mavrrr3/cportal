import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/connecting_code_mobile/connecting_code_info_mobile_popup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showConnectingInfo(BuildContext context) {
  isLargerThenTablet(context)
      ? context.pushNamed(NavigationRouteNames.connectingCodeInfo)
      : showDialog<void>(
          context: context,
          builder: (context) => const ConnectingCodeInfoMobilePopup(),
        );
}
