import 'package:flutter/material.dart';

/// Bottom space.
class BottomPadding extends StatelessWidget {
  /// Use, then [MediaQuery.of(context).padding.bottom] = 0.
  ///
  /// By default height is 16.
  final double height;

  /// Create bottom space.
  const BottomPadding({
    Key? key,
    this.height = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final spaceHeight = bottomPadding == 0 ? height : bottomPadding;

    return SizedBox(height: spaceHeight);
  }
}
