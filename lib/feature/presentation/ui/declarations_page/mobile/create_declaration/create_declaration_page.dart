import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/declaration_info/widgets/declaration_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/widgets/declaration_card.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class CreateDeclarationPage extends StatefulWidget {
  const CreateDeclarationPage({Key? key}) : super(key: key);

  @override
  State<CreateDeclarationPage> createState() => _CreateDeclarationPageState();
}

class _CreateDeclarationPageState extends State<CreateDeclarationPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final halfWidth = (MediaQuery.of(context).size.width - 48) / 2;

    return Swipe(
      onSwipeRight: () => context.pop(),
      child: Scaffold(
        backgroundColor: theme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeclarationAppBar(
                    title: AppLocalizations.of(context)!.newDeclaration,
                  ),
                  // Строка с поиском.
                  SearchWithFilter(
                    padding: EdgeInsets.zero,
                    searchController: searchController,
                    onSearch: (text) {},
                    onFilterTap: () {},
                  ),
                  const SizedBox(height: 73),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.calendar,
                        text: AppLocalizations.of(context)!
                            .buisenesTripDeclaration,
                      ),
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.flyVocation,
                        text: AppLocalizations.of(context)!.vocationDeclaration,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.lock,
                        text: AppLocalizations.of(context)!.passDeclaration,
                      ),
                      DeclarationCard(
                        width: halfWidth,
                        svgPath: ImageAssets.payList,
                        text: AppLocalizations.of(context)!.payListDeclaration,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DeclarationCard(
                    width: double.infinity,
                    svgPath: ImageAssets.support,
                    text: AppLocalizations.of(context)!.supportDeclaration,
                  ),
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

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
