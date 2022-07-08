// ignore_for_file: prefer_if_elements_to_conditional_expressions

import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/step_status.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/declarations_bloc/single_declaration_bloc/single_declaration_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_data.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_date_and_priority.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_progress.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_steps_history.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_user.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/button.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
    BlocProvider.of<SingleDeclarationBloc>(
      context,
      listen: false,
    ).add(GetSingleDeclarationEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMMM', 'ru');
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final double width = MediaQuery.of(context).size.width;

    return Swipe(
      onSwipeRight: () => context.pop(),
      child: Scaffold(
        backgroundColor: theme.background,

        body: BlocBuilder<SingleDeclarationBloc, SingleDeclarationState>(
          builder: (context, state) {
            if(state is SingleDeclarationLoadedState){


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
                        progress: state.declaration.progress,
                        currentStep: _getCurrentStep(state.declaration.steps),
                      ),
                      const SizedBox(height: 24),

                      // История этапов.
                      DeclarationStepsHistory(
                        steps: state.declaration.steps,
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
                        date: DateTime.now(),
                        priority: state.declaration.priority,
                      ),
                      const SizedBox(height: 24),

                      // Инциатор.
                      DeclarationUser(
                        title: AppLocalizations.of(context)!.initiator,
                        user: state.declaration.initiator,
                      ),

                      // Ответственный.
                      const SizedBox(height: 16),
                      DeclarationUser(
                        title: AppLocalizations.of(context)!.responsible,
                        user: state.declaration.responsible,
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
                      DeclarationData(data: state.declaration.data),
                      const SizedBox(height: 32),

                      state.declaration.progress != 1
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
                              text: AppLocalizations.of(context)!.archiveDeclaration,
                              size: Size(width - 32, 48),
                            ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
            }
            return SizedBox();
          },
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

  String _getCurrentStep(List<DeclarationStepEntity> items) =>
      items.firstWhere((element) => element.status == StepStatus.inProcess).title;
}
