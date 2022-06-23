
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contact_card.dart';

class ContactsListWeb extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  /// Список контактов для Web версии.
  const ContactsListWeb({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          items.length,
          (i) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              onTap(i);
            },
            child: ContactCard(
              user: items[i],
              width: ResponsiveWrapper.of(
                context,
              ).isLargerThan(MOBILE)
                  ? 328
                  : null,
            ),
          ),
        ),
      );
  }
}
