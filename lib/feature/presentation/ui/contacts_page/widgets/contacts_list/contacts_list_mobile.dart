import 'package:flutter/material.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contact_card.dart';

class ContactsListMobile extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  /// Список контактов для мобильной версии.
  const ContactsListMobile({
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
