import 'package:cportal_flutter/feature/presentation/ui/declarations_page/tabs_pages/all_declarations.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/tabs_pages/new_declarations.dart';
import 'package:flutter/material.dart';

class DeclarationsTabsContent extends StatelessWidget {
  final TabController tabController;

  const DeclarationsTabsContent({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(controller: tabController, children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                    child: AllDeclarations(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: NewDeclarations(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
