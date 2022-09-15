import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_documents.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PickedDocs extends StatelessWidget {
  final List<PlatformFile> items;
  final Function(int) onRemove;
  const PickedDocs({
    super.key,
    required this.items,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            items.length,
            (i) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      getIconByFileType(items[i].name),
                      width: 24,
                      color: theme.textLight,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 96,
                      ),
                      child: Text(
                        items[i].name,
                        style: theme.textTheme.px14Bold
                            .copyWith(color: theme.primary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => onRemove(i),
                  child: SvgPicture.asset(
                    ImageAssets.close,
                    width: 24,
                    color: theme.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFileName(String name) {
    return name.length < 30 ? name : '${name.substring(0, 25)}...';
  }
}
