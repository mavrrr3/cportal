// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_data.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_steps_history.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_user.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class DeclarationInfoPage extends StatefulWidget {
  const DeclarationInfoPage({Key? key}) : super(key: key);

  @override
  State<DeclarationInfoPage> createState() => _DeclarationInfoPageState();
}

class _DeclarationInfoPageState extends State<DeclarationInfoPage> {
  late bool _isHistoryExpanded;

  @override
  void initState() {
    super.initState();
    _isHistoryExpanded = true;
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final double width = MediaQuery.of(context).size.width;

    return Swipe(
      onSwipeRight: () => context.pop(),
      child: Scaffold(
        backgroundColor: theme.background,

        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar.
                  DeclarationAppBar(title: declarationInfoMock.title),

                  // Прогресс и текущий этап.
                  // DeclarationProgress(
                  //   progress: declarationInfoMock.progress,
                  //   currentStep: _getCurrentStep(declarationInfoMock.steps),
                  // ),
                  const SizedBox(height: 24),

                  // История этапов.
                  DeclarationStepsHistory(
                    steps: declarationInfoMock.steps,
                    isHistoryExpanded: _isHistoryExpanded,
                    onTap: () {
                      setState(() {
                        _isHistoryExpanded = !_isHistoryExpanded;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Дата и приоритет.
                  // DeclarationDateAndPriority(
                  //   date: declarationInfoMock.date,
                  //   priority: declarationInfoMock.priority,
                  // ),
                  const SizedBox(height: 24),

                  // Инциатор.
                  DeclarationUser(
                    title: AppLocalizations.of(context)!.initiator,
                    user: declarationInfoMock.initiator,
                  ),

                  // Ответственный.
                  const SizedBox(height: 16),
                  DeclarationUser(
                    title: AppLocalizations.of(context)!.responsible,
                    user: declarationInfoMock.responsible,
                  ),
                  const SizedBox(height: 24),
                  Divider(
                    color: theme.brightness == Brightness.light
                        ? theme.black?.withOpacity(0.08)
                        : theme.textLight?.withOpacity(0.08),
                    height: 1,
                  ),
                  const SizedBox(height: 16),

                  // Подробная информация о заявлении.
                  DeclarationData(data: declarationInfoMock.data),
                  const SizedBox(height: 32),

                  declarationInfoMock.progress != 1
                      ? Button.factory(
                          context,
                          type: ButtonEnum.filled,
                          onTap: () {},
                          text: AppLocalizations.of(context)!.cancelDeclaration,
                          color: theme.red,
                          size: Size(width - 32, 48),
                        )
                      : Button.factory(
                          context,
                          type: ButtonEnum.outlined,
                          onTap: () {},
                          text:
                              AppLocalizations.of(context)!.archiveDeclaration,
                          size: Size(width - 32, 48),
                        ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        // Отозвать заявление.

        bottomNavigationBar: !kIsWeb
            ? BlocBuilder<NavigationBarBloc, NavigationBarState>(
                builder: (context, state) {
                  return CustomBottomBar(
                    state: state,
                    isNestedNavigation: true,
                  );
                },
              )
            : null,
      ),
    );
  }

  // String _getCurrentStep(List<DeclarationStepEntity> items) => items
  //     .firstWhere((element) => element.status == StepStatus.inProgress)
  //     .title;
}
