import 'package:cportal_flutter/common/custom_theme.dart';
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
            user: items[index],
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final ProfileEntity user;
  final double? width;

  /// Карточка контакта.
  const ContactCard({
    Key? key,
    required this.user,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_if_elements_to_conditional_expressions
              user.photoLink != ''
                  ? AvatarBox(
                      size: 48,
                      imgPath: user.photoLink,
                      borderRadius: 6,
                    )
                  : EmptyAvatarBox(
                      user: user,
                    ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.px14
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.position,
                      style: theme.textTheme.px12.copyWith(
                        color: theme.textLight,
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

class EmptyAvatarBox extends StatelessWidget {
  final ProfileEntity user;
  final double size;
  final double borderRadius;
  const EmptyAvatarBox({
    Key? key,
    required this.user,
    this.size = 48,
    this.borderRadius = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: user.color,
      ),
      child: Center(
        child: Text(
          getShortName(user.fullName),
          style: theme.textTheme.px22.copyWith(
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}

String getShortName(String name) {
  final nameList = name.split(' ');

  return '${nameList.first[0]} ${nameList[1][0]}';
}
