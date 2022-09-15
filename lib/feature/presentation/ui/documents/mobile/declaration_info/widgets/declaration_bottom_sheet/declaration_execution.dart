import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/create_declaration/widgets/declaration_textfield.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_bottom_sheet/picked_docs.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_expandble_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_upload_docs_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationExecution extends StatefulWidget {
  final Function() fileActionCallBack;
  const DeclarationExecution({super.key, required this.fileActionCallBack});

  @override
  State<DeclarationExecution> createState() => _DeclarationExecutionState();
}

class _DeclarationExecutionState extends State<DeclarationExecution> {
  late final TextEditingController commentController;
  late List<PlatformFile> pickedFiles;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    pickedFiles = [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок и описание.
        DeclarationExpandbleContent(
          title: localizedStrings.executionNeeds,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Идейные соображения высшего порядка, а также граница обучения кадров играет определяющее значение для направлений прогрессивного развития. Предварительные выводы неутешительны: семантический разбор внешних противодействий требует от нас анализа экономической целесообразности принимаемых решений. Как принято считать, явные признаки победы институционализации.',
                style: theme.textTheme.px14.copyWith(color: theme.textLight),
              ),
            ],
          ),
          childTopPadding: 0,
        ),
        const SizedBox(height: 24),

        if (pickedFiles.isNotEmpty)
          PickedDocs(
            items: pickedFiles,
            onRemove: (i) {
              setState(() {
                pickedFiles.removeAt(i);
              });
              widget.fileActionCallBack();
            },
          ),

        // Кнопка "Загрузить".
        Button.factory(
          context,
          type: ButtonEnum.dottedLine,
          text: localizedStrings.upload,
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              allowMultiple: true,
            );
            if (result != null) {
              setState(() {
                pickedFiles.addAll(result.files);
              });
              widget.fileActionCallBack();
            }
          },
        ),
        const SizedBox(height: 32),

        // Комментарий.
        DeclarationTextField(
          controller: commentController,
          title: localizedStrings.comment,
        ),
        const SizedBox(height: 32),

        // Кнопка "Готово".
        DeclarationUploadDocsButton(
          isActive: pickedFiles.isNotEmpty,
          onTap: () {},
        ),
      ],
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
