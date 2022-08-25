// ignore_for_file: prefer_int_literals

import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/pin_code/pin_dot.dart';
import 'package:flutter/material.dart';

class MobilePinCodeField extends StatefulWidget {
  final TextEditingController controller;
  const MobilePinCodeField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MobilePinCodeField> createState() => _MobilePinCodeFieldState();
}

class _MobilePinCodeFieldState extends State<MobilePinCodeField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PinDot(controller: widget.controller, symbolIndex: 1),
        const SizedBox(width: 32),
        PinDot(controller: widget.controller, symbolIndex: 2),
        const SizedBox(width: 32),
        PinDot(controller: widget.controller, symbolIndex: 3),
        const SizedBox(width: 32),
        PinDot(controller: widget.controller, symbolIndex: 4),
      ],
    );
  }
}
