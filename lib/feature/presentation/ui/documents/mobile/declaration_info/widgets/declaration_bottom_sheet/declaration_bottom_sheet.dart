import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/color_service.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_bottom_sheet/declaration_introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeclarationBottomSheet extends StatefulWidget {
  const DeclarationBottomSheet({super.key});

  @override
  State<DeclarationBottomSheet> createState() => _DeclarationBottomSheetState();
}

class _DeclarationBottomSheetState extends State<DeclarationBottomSheet> {
  late int _currentIndex;
  late final PageController _pageController;
  late final DraggableScrollableController _draggableScrollableController;
  late final List<Color> _colors;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    _draggableScrollableController = DraggableScrollableController();
    _colors = [
      ColorService.randomColor,
      ColorService.randomColor,
      ColorService.randomColor,
      ColorService.randomColor,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DraggableScrollableSheet(
        controller: _draggableScrollableController,
        expand: false,
        initialChildSize: 0.09,
        maxChildSize: 0.94,
        minChildSize: 0.09,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: theme.brightness == Brightness.light
                    ? theme.black!.withOpacity(0.04)
                    : theme.black!.withOpacity(0.08),
              ),
              BoxShadow(
                offset: const Offset(0, -4),
                blurRadius: 8,
                color: theme.brightness == Brightness.light
                    ? theme.black!.withOpacity(0.06)
                    : theme.black!.withOpacity(0.12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.text?.withOpacity(0.48),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        4,
                        (i) => Padding(
                          padding: EdgeInsets.only(right: i != 4 - 1 ? 8 : 0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentIndex != i
                                  ? theme.text?.withOpacity(0.17)
                                  : theme.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 190,
                    child: PageView.builder(
                      itemCount: 4,
                      onPageChanged: (value) {
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                      itemBuilder: (context, i) => DeclarationIntroduction(
                        onTapResults: () {
                          _draggableScrollableController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                        },
                        onDone: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
