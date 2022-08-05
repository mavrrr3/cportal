import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/form_widgets/declaration_textfield.dart';
import 'package:flutter/material.dart';

class CreateDeclarationPage extends StatefulWidget {
  final String id;

  const CreateDeclarationPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CreateDeclarationPage> createState() => _CreateDeclarationPageState();
}

class _CreateDeclarationPageState extends State<CreateDeclarationPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Scaffold(
      backgroundColor: theme.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              DeclarationTextField(
                controller: _controller,
                title: 'ФИО посетителя',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
