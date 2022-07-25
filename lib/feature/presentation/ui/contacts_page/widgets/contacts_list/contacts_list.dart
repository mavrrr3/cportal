import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contacts_list_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contacts_list_mobile.dart';

class ContactsList extends StatelessWidget {
  final List<ProfileEntity> items;
  final Function(int) onTap;

  /// Рендеринг контактов.
  const ContactsList({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getHorizontalPadding(context),
      child: kIsWeb
          ? ContactsListWeb(items: items, onTap: onTap)
          : ContactsListMobile(items: items, onTap: onTap),
    );
  }
}
