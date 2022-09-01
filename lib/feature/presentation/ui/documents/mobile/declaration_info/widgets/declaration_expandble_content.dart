import 'package:cportal_flutter/feature/presentation/ui/documents/mobile/declaration_info/widgets/declaration_headline.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class DeclarationExpandbleContent extends StatefulWidget {
  final String title;
  final Widget child;
  final double childTopPadding;
  const DeclarationExpandbleContent({
    super.key,
    required this.title,
    required this.child,
    required this.childTopPadding,
  });

  @override
  State<DeclarationExpandbleContent> createState() =>
      _DeclarationExpandbleContentState();
}

class _DeclarationExpandbleContentState
    extends State<DeclarationExpandbleContent>
    with SingleTickerProviderStateMixin {
  late ExpandableController _expandController;
  late AnimationController _arrowController;

  @override
  void initState() {
    super.initState();
    _expandController = ExpandableController(initialExpanded: true);
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _arrowController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeclarationHeadline(
          title: widget.title,
          isArrow: _expandController.expanded,
          controller: _arrowController,
          onTap: () {
            setState(() {
              _expandController.toggle();
            });

            if (_expandController.expanded) {
              _arrowController.reverse(from: 0.5);
            } else {
              _arrowController.forward(from: 0);
            }
          },
        ),
        ExpandablePanel(
          controller: _expandController,
          expanded: Padding(
            padding: EdgeInsets.only(top: widget.childTopPadding),
            child: widget.child,
          ),
          collapsed: const SizedBox(),
        ),
      ],
    );
  }
}
