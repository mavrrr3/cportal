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
        // InProcessDeclarations(),
        // ComplitedDeclarations(),
      ],
    );
  }
}
