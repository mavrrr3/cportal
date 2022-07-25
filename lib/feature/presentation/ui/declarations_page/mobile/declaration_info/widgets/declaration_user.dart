import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_user_entity.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/user_card.dart';
import 'package:flutter/material.dart';

class DeclarationUser extends StatelessWidget {
  final String title;
  final DeclarationUserEntity user;
  const DeclarationUser({Key? key, required this.title, required this.user,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.px14,
        ),
        const SizedBox(height: 8),
        UserCard(
          fullName: user.fullName,
          position: user.position,
          imgLink: user.image,
          color: user.color,
        ),
      ],
    );
  }
}
