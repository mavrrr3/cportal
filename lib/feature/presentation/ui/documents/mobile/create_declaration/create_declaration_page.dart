import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/widgets/create_declaration_cards.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/foundation.dart';
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
  late TextEditingController _searchController;
  late FocusNode _searchFocus;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
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
                    searchController: _searchController,
                    currentMenuIndex: 3,
                    onSearch: (text) {},
                    onSearchClear: () {},
                    onFilterTap: () {},
                  ),
                  const SizedBox(height: 73),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CreateDeclarationCards(
                        width: halfWidth,
                        svgPath: ImageAssets.calendar,
                        text: AppLocalizations.of(context)!
                            .buisenesTripDeclaration,
                      ),
                      CreateDeclarationCards(
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
                      CreateDeclarationCards(
                        width: halfWidth,
                        svgPath: ImageAssets.lock,
                        text: AppLocalizations.of(context)!.passDeclaration,
                      ),
                      CreateDeclarationCards(
                        width: halfWidth,
                        svgPath: ImageAssets.payList,
                        text: AppLocalizations.of(context)!.payListDeclaration,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CreateDeclarationCards(
                    width: double.infinity,
                    svgPath: ImageAssets.support,
                    text: AppLocalizations.of(context)!.supportDeclaration,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            !kIsWeb ? const CustomBottomBar(isNestedNavigation: true) : null,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
  }
}
