import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_bottom_sheet/declaration_introduction.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_bottom_sheet/declaration_agreement.dart';
import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_bottom_sheet/declaration_execution.dart';
import 'package:cportal_flutter/common/util/keep_alive_page.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DeclarationTasksAnimatedSheet extends StatefulWidget {
  const DeclarationTasksAnimatedSheet({super.key});

  @override
  State<DeclarationTasksAnimatedSheet> createState() =>
      _DeclarationTasksAnimatedSheetState();
}

class _DeclarationTasksAnimatedSheetState
    extends State<DeclarationTasksAnimatedSheet> {
  late int _currentIndex;
  late final PageController _pageController;
  late final ScrollController _scrollController;
  late final List<Widget> _tasks;
  late final GlobalKey _key;
  late final double _minHeight;
  late double _currentHeight;
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    _scrollController = ScrollController();
    // Чтобы отслеживать высоту колонки в каждой задаче.
    _key = GlobalKey();

    _minHeight = 68;
    _currentHeight = _minHeight;

    _tasks = [
      DeclarationAgreement(
        description: 'Требуется согласование',
        onAgreed: () {},
      ),
      DeclarationExecution(
        fileActionCallBack: () async {
          await _updateHeight();
        },
      ),
      DeclarationIntroduction(onTapResults: () {}, onDone: () {}),
      DeclarationAgreement(
        description: 'Требуется согласование',
        onAgreed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      // Отвечают за раскрытие шторки.
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        if (_currentHeight == _minHeight) {
          await _updateHeight();
        }
      },
      onVerticalDragUpdate: (details) async {
        const int sensitivity = 15;
        if (details.delta.dy < -sensitivity) {
          if (_currentHeight == _minHeight) {
            await _updateHeight();
          }
        }
      },
      //
      child: AnimatedContainer(
        height: _currentHeight,
        width: width,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: _getSheetDecoration(theme),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notify) {
            // Если true, шторка скрывается.
            if (notify is UserScrollNotification &&
                notify.metrics.axis == Axis.vertical &&
                notify.direction == ScrollDirection.forward &&
                notify.metrics.atEdge) {
              if (_scrollController.position.pixels == 0) {
                _setDefaultHeight();
              }
            }

            return false;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: isDefaultHeight
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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

                // Виджет, отображающий текущую позицию в карусели.
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _tasks.length,
                        (i) => Padding(
                          padding: EdgeInsets.only(right: i != 4 - 1 ? 8 : 0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 25),
                            curve: Curves.easeInOut,
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentIndex != i
                                  ? theme.text?.withOpacity(0.17)
                                  : theme.documentRed,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Контент карусели [Задачи].
                ExpandablePageView(
                  key: _key,
                  controller: _pageController,
                  animationDuration: const Duration(milliseconds: 150),
                  physics: isDefaultHeight
                      ? const NeverScrollableScrollPhysics()
                      : const PageScrollPhysics(),
                  onPageChanged: (value) async {
                    setState(() {
                      _currentIndex = value;
                    });
                    await _updateHeight();
                  },
                  children: List.generate(
                    _tasks.length,
                    (i) => Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      child: KeepAlivePage(child: _tasks[i]),
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

  Future<void> _updateHeight() async {
    if (_key.currentContext != null) {
      if (_key.currentContext!.size != null) {
        await Future<dynamic>.delayed(
          const Duration(milliseconds: 300),
        );

        setState(() {
          _currentHeight = _key.currentContext!.size!.height + 24;
        });
      }
    }
  }

  Future<void> _setDefaultHeight() async {
    setState(() {
      _currentHeight = _minHeight;
    });
  }

  bool get isDefaultHeight => _currentHeight == _minHeight;

  BoxDecoration _getSheetDecoration(CustomTheme theme) {
    return BoxDecoration(
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
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
