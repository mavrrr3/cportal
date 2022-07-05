import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:flutter/material.dart';

class DeclarationProgress extends StatefulWidget {
  final double progress;
  final String? currentStep;
  final int duration;

  const DeclarationProgress({
    Key? key,
    required this.progress,
    required this.currentStep,
    this.duration = 650,
  }) : super(key: key);

  @override
  State<DeclarationProgress> createState() => _DeclarationProgressState();
}

class _DeclarationProgressState extends State<DeclarationProgress> {
  late double progress;

  @override
  void initState() {
    super.initState();
    progressAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 24,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: theme.text?.withOpacity(0.16),
              ),
            ),
            AnimatedContainer(
              height: 24,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: widget.duration),
              width: width * progress,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: widget.progress < 1 ? theme.yellow : theme.progressDone,
              ),
            ),
          ],
        ),
        if (widget.currentStep != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.currentStep!,
              style: theme.textTheme.px16,
            ),
          ),
      ],
    );
  }

  Future<void> progressAnimation() async {
    if (widget.progress > 0) {
      setState(() {
        progress = 0;
      });
      await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      setState(() {
        progress = widget.progress / 2;
      });
      await Future<dynamic>.delayed(const Duration(milliseconds: 5));
      setState(() {
        progress = widget.progress;
      });
    }
  }
}
