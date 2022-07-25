import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class OnTapNotify extends StatefulWidget {
  final Widget child;
  final String text;

  const OnTapNotify({
    Key? key,
    required this.text,
    required this.child,
  }) : super(key: key);

  @override
  State<OnTapNotify> createState() => _OnTapNotifyState();
}

class _OnTapNotifyState extends State<OnTapNotify> {
  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();

        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: theme.black,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              content: Text(
                widget.text,
                style: theme.textTheme.px14.copyWith(
                  color: theme.brightness == Brightness.light
                      ? theme.cardColor
                      : theme.background,
                ),
              ),
            ),
          );
        });
      },
      child: widget.child,
    );
  }
}
