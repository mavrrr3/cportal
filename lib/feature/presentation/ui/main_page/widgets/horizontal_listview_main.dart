import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/card_horizontal_scroll.dart';
import 'package:flutter/material.dart';

class HorizontalListViewMain extends StatelessWidget {
  final Color color;

  const HorizontalListViewMain({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLargerThenTablet(context)
        ? Padding(
            padding: getHorizontalPadding(context),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                gridViewMap.length,
                (i) => CardHorizontalScroll(
                  icon: gridViewMap[i]['icon'] as IconData,
                  text: gridViewMap[i]['text'] as String,
                  color: color,
                ),
              ),
            ),
          )
        : SizedBox(
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
                      CardHorizontalScroll(
                        icon: gridViewMap[i]['icon'] as IconData,
                        text: gridViewMap[i]['text'] as String,
                        color: color,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}

final List<Map<String, dynamic>> gridViewMap = [
  <String, dynamic>{
    'icon': Icons.account_circle_outlined,
    'text': 'Для новых сотрудников',
  },
  <String, dynamic>{
    'icon': Icons.yard_outlined,
    'text': 'Погружение в сферу',
  },
  <String, dynamic>{
    'icon': Icons.ac_unit_outlined,
    'text': 'Погружение в сферу',
  },
  <String, dynamic>{
    'icon': Icons.ac_unit_outlined,
    'text': 'Погружение в сферу',
  },
  <String, dynamic>{
    'icon': Icons.ac_unit_outlined,
    'text': 'Погружение в сферу',
  },
];
