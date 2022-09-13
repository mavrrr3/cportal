import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/responsive_util.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/card_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalListViewMain extends StatelessWidget {
  final Color color;

  const HorizontalListViewMain({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? SizedBox(
            height: 92,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: gridViewMap.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? getSingleHorizontalPadding(context) : 0,
                    right: i == gridViewMap.length - 1
                        ? getSingleHorizontalPadding(context)
                        : 8,
                  ),
                  child: Row(
                    children: [
                      CardWithIcon(
                        svgPath: gridViewMap[i]['icon'] as String,
                        width: 148,
                        text: gridViewMap[i]['text'] as String,
                        color: color,
                        onTap: () => context
                            .goNamed(NavigationRouteNames.onBoardingStart),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(
              gridViewMap.length,
              (i) => CardWithIcon(
                width: 148,
                svgPath: gridViewMap[i]['icon'] as String,
                text: gridViewMap[i]['text'] as String,
                color: color,
                onTap: () =>
                    context.goNamed(NavigationRouteNames.onBoardingStart),
              ),
            ),
          );
  }
}

final List<Map<String, dynamic>> gridViewMap = [
  <String, dynamic>{
    'icon': ImageAssets.profile,
    'text': 'Для новых сотрудников',
  },
  <String, dynamic>{
    'icon': ImageAssets.video,
    'text': 'Погружение \nв сферу',
  },
  <String, dynamic>{
    'icon': ImageAssets.video,
    'text': 'Погружение \nв сферу',
  },
  <String, dynamic>{
    'icon': ImageAssets.video,
    'text': 'Погружение \nв сферу',
  },
  <String, dynamic>{
    'icon': ImageAssets.video,
    'text': 'Погружение \nв сферу',
  },
];
