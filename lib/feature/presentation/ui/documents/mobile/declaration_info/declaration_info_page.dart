// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_bottom_sheet/declaration_bottom_sheet.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_data.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_date_and_priority.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_documents.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_expandble_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_initiator.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_progress.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_actions_history.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:swipe/swipe.dart';

class DeclarationInfoPage extends StatefulWidget {
  final String id;
  final bool isTask;
  const DeclarationInfoPage({
    Key? key,
    required this.id,
    required this.isTask,
  }) : super(key: key);

  @override
  State<DeclarationInfoPage> createState() => _DeclarationInfoPageState();
}

class _DeclarationInfoPageState extends State<DeclarationInfoPage> {
  @override
  void initState() {
    super.initState();
    context.read<SingleDeclarationBloc>().add(GetSingleDeclarationEvent(
          id: widget.id,
          isTask: widget.isTask,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Swipe(
      onSwipeRight: () => context.pop(),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: theme.background,
          body: BlocBuilder<SingleDeclarationBloc, SingleDeclarationState>(
            builder: (context, state) {
              if (state is SingleDeclarationLoadingState) {
                return const Center(child: PlatformProgressIndicator());
              }

              if (state is SingleDeclarationLoadedState) {
                return SafeArea(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SingleChildScrollView(
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
                              DeclarationAppBar(
                                title: state.declaration.title,
                              ),

                              // Прогресс и текущий этап.
                              DeclarationProgress(
                                currentStep: state.declaration.currentStep,
                                allSteps: state.declaration.allSteps,
                                status: state.declaration.status,
                                description:
                                    state.declaration.progressDescription,
                                color: ColorService.declarationStatus(
                                  state.declaration.status,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Содержание.
                              if (state.declaration.content != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: DeclarationExpandbleContent(
                                    title: localizedStrings.content,
                                    childTopPadding: 8,
                                    child: Text(
                                      state.declaration.content!,
                                      style: theme.textTheme.px14,
                                    ),
                                  ),
                                ),

                              // Ход выполнения.
                              if (state.declaration.actions.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: DeclarationActionsHistory(
                                    actions: state.declaration.actions,
                                  ),
                                ),

                              // Документы.
                              if (state.declaration.documents.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: DeclarationDocuments(
                                    items: state.declaration.documents,
                                    onTap: (i) {},
                                  ),
                                ),

                              // Дата и приоритет.
                              DeclarationDateAndPriority(
                                date: state.declaration.date,
                                priority: state.declaration.priority,
                              ),
                              const SizedBox(height: 24),

                              // Инициатор.
                              if (state.declaration.initiatorName != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: DeclarationInitiator(
                                    fullName: state.declaration.initiatorName!,
                                    position:
                                        state.declaration.initiatorPosition!,
                                    imgLing: state.declaration.initiatorImage!,
                                  ),
                                ),

                              Divider(
                                color: theme.brightness == Brightness.light
                                    ? theme.black?.withOpacity(0.08)
                                    : theme.textLight?.withOpacity(0.08),
                                height: 1,
                              ),
                              const SizedBox(height: 16),

                              // Подробная информация о заявлении.
                              if (state.declaration.params.isNotEmpty)
                                DeclarationData(data: state.declaration.params),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
                      const DeclarationBottomSheet(),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
          // Отозвать заявление.
        ),
      ),
    );
  }
}
