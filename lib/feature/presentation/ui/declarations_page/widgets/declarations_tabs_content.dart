import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/tabs_pages/all_declarations.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/mobile/tabs_pages/new_declarations.dart';
import 'package:flutter/material.dart';

class DeclarationsTabsContent extends StatelessWidget {
  final TabController tabController;

  const DeclarationsTabsContent({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        AllDeclarations(),
        NewDeclarations(),
      ],
    );
  }
}
