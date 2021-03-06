import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_info_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/declaration_step_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/declarations/step_status.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
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
import 'package:flutter_svg/svg.dart';
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
    _isHistoryExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(
                          ImageAssets.backArrow,
                          width: 16,
                          color: theme.text,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        declarationInfoMock.title,
                        style: theme.textTheme.px22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 38),

                  // ???????????????? ?? ?????????????? ????????.
                  DeclarationProgress(
                    progress: declarationInfoMock.progress,
                    currentStep: _getCurrentStep(declarationInfoMock.steps),
                  ),
                  const SizedBox(height: 24),

                  // ?????????????? ????????????.
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

                  // ???????? ?? ??????????????????.
                  DeclarationDateAndPriority(
                    date: declarationInfoMock.date,
                    priority: declarationInfoMock.priority,
                  ),
                  const SizedBox(height: 24),

                  // ????????????????.
                  DeclarationUser(
                    title: AppLocalizations.of(context)!.initiator,
                    user: declarationInfoMock.initiator,
                  ),

                  // ??????????????????????????.
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

                  // ?????????????????? ???????????????????? ?? ??????????????????.
                  DeclarationData(data: declarationInfoMock.data),
                  const SizedBox(height: 60),

                  // ???????????????? ??????????????????.
                  Button.factory(
                    context,
                    ButtonEnum.blue,
                    AppLocalizations.of(context)!.cancel_declaration,
                    () {},
                    Size(MediaQuery.of(context).size.width - 32, 48),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
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
      items.firstWhere((element) => element.status == StepStatus.inProgress).title;
}
