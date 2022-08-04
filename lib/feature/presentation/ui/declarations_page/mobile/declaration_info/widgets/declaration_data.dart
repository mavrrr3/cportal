import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_data_entity.dart';
import 'package:flutter/material.dart';

class DeclarationData extends StatelessWidget {
  final List<DeclarationDataEntity> data;
  const DeclarationData({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        data.length,
        (i) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[i].title,
              style: theme.textTheme.px14,
            ),
            const SizedBox(height: 4),
            Text(
              data[i].description,
              style: theme.textTheme.px16.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
