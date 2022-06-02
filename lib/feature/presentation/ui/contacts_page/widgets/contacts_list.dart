import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/tag_container.dart';
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
              AvatarBox(
                size: 48,
                imgPath: item.photoLink,
                isApiImg: false,
                borderRadius: 10.38,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.firstName} ${item.middleName} ${item.lastName}',
                      style: theme.textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.position.description,
                      style: theme.textTheme.bodyText1!.copyWith(
                        color: theme.hoverColor.withOpacity(0.68),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TagContainer(text: item.position.department),
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
