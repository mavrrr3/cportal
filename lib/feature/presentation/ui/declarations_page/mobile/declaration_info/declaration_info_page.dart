// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_data.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_date_and_priority.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_progress.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_steps_history.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class DeclarationInfoPage extends StatefulWidget {
  final String id;
  const DeclarationInfoPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DeclarationInfoPage> createState() => _DeclarationInfoPageState();
}

class _DeclarationInfoPageState extends State<DeclarationInfoPage> {
  late bool _isHistoryExpanded;

  @override
  void initState() {
    super.initState();
    _isHistoryExpanded = true;
    context
        .read<SingleDeclarationBloc>()
        .add(GetSingleDeclarationEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Swipe(
      onSwipeRight: () => context.pop(),
      child: Scaffold(
        backgroundColor: theme.background,

        body: BlocBuilder<SingleDeclarationBloc, SingleDeclarationState>(
          builder: (context, state) {
            if (state is SingleDeclarationLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SingleDeclarationLoadedState) {
              return SafeArea(
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
                        DeclarationAppBar(title: state.declaration.title),

                        // Прогресс и текущий этап.
                        DeclarationProgress(
                          currentStep: state.declaration.currentStep,
                          allSteps: state.declaration.allSteps,
                          status: state.declaration.status,
                          description: state.declaration.progressDescription,
                          color: ColorService.declarationStatus(
                            state.declaration.status,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // История этапов.
                        DeclarationStepsHistory(
                          steps: state.declaration.actions,
                          isHistoryExpanded: _isHistoryExpanded,
                          onTap: () {
                            setState(() {
                              _isHistoryExpanded = !_isHistoryExpanded;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Дата и приоритет.
                        DeclarationDateAndPriority(
                          date: state.declaration.date,
                          priority: state.declaration.priority,
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
                        DeclarationData(data: state.declaration.params),
                        const SizedBox(height: 32),

                        // state.declaration.progress != 1
                        //     ? Button.factory(
                        //         context,
                        //         type: ButtonEnum.filled,
                        //         onTap: () {},
                        //         text: AppLocalizations.of(context)!
                        //             .cancelDeclaration,
                        //         color: theme.red,
                        //         size: Size(width - 32, 48),
                        //       )
                        //     : Button.factory(
                        //         context,
                        //         type: ButtonEnum.outlined,
                        //         onTap: () {},
                        //         text: AppLocalizations.of(context)!
                        //             .archiveDeclaration,
                        //         size: Size(width - 32, 48),
                        //       ),
                        // const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        // Отозвать заявление.

        bottomNavigationBar: !kIsWeb
            ? const CustomBottomBar(
                isNestedNavigation: true,
              )
            : null,
      ),
    );
  }
}
