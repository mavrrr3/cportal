import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class DeclarationProgress extends StatefulWidget {
  final int currentStep;
  final int allSteps;
  final String status;
  final String description;
  final Color color;
  final int duration;

  const DeclarationProgress({
    Key? key,
    required this.currentStep,
    required this.allSteps,
    required this.status,
    required this.description,
    required this.color,
    this.duration = 650,
  }) : super(key: key);

  @override
  State<DeclarationProgress> createState() => _DeclarationProgressState();
}

class _DeclarationProgressState extends State<DeclarationProgress> {
  late double progress;
  late double progressForAnimation;

  @override
  void initState() {
    super.initState();
    progress = widget.currentStep / widget.allSteps;
    progressAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.status,
              style: theme.textTheme.px16Bold,
            ),
            Text(
              '${widget.currentStep}/${widget.allSteps}',
              style: theme.textTheme.px16,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 24,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: theme.text?.withOpacity(0.08),
              ),
            ),
            AnimatedContainer(
              height: 24,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: widget.duration),
              width: width * progressForAnimation,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: widget.color,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            widget.description,
            style: theme.textTheme.px16,
          ),
        ),
      ],
    );
  }

  Future<void> progressAnimation() async {
    if (progress > 0) {
      if (mounted) {
        setState(() {
          progressForAnimation = 0;
        });
      }

      await Future<dynamic>.delayed(const Duration(milliseconds: 5));
       if (mounted) {
        setState(() {
          progressForAnimation = progress / 2;
        });
      }
      
      await Future<dynamic>.delayed(const Duration(milliseconds: 5));
       if (mounted) {
        setState(() {
          progressForAnimation = progress;
        });
      }
 
    }
  }
}
