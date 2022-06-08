import 'dart:math';

import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  /// Колонка с контактами.
  const ContactsList({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GestureDetector(
          onTap: () {
            onTap(index);
          },
          child: ContactCard(
            item: items[index],
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final ProfileEntity item;
  final double? width;

  /// Карточка контакта.
  const ContactCard({
    Key? key,
    required this.item,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: theme.splashColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_if_elements_to_conditional_expressions
              item.photoLink != ''
                  ? AvatarBox(
                      size: 48,
                      imgPath: item.photoLink,
                      borderRadius: 6,
                    )
                  : _EmptyAvatarBox(
                      name: _getShortName(item.fullName),
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.fullName,
                      style: theme.textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.position,
                      style: theme.textTheme.bodyText1!.copyWith(
                        color: theme.hoverColor.withOpacity(0.68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // TagContainer(text: item.position.department),.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyAvatarBox extends StatelessWidget {
  final String name;
  const _EmptyAvatarBox({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: _randomColor(),
      ),
      child: Center(
        child: Text(
          name,
          style: theme.textTheme.headline3!.copyWith(
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}

String _getShortName(String name) {
  final nameList = name.split(' ');

  return '${nameList.first[0]} ${nameList[1][0]}';
}

Color _randomColor() {
  const List<Color> colors = [
    Color(0xFFB1E5FC),
    Color(0xFFFFD88D),
    Color(0xFFB5E4CA),
    Color(0xFFFFBC99),
    Color(0xFFCABDFF),
  ];
  final int random = Random().nextInt(colors.length);

  return colors[random];
}
