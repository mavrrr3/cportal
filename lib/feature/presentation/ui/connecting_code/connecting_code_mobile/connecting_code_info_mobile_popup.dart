import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/phone_button.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/document.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_code/widgets/work_mode_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnectingCodeInfoMobilePopup extends StatefulWidget {
  const ConnectingCodeInfoMobilePopup({Key? key}) : super(key: key);

  @override
  State<ConnectingCodeInfoMobilePopup> createState() => _ConnectingCodeInfoMobilePopupState();
}

class _ConnectingCodeInfoMobilePopupState extends State<ConnectingCodeInfoMobilePopup>
    with SingleTickerProviderStateMixin {
  final _iconAnimation = Tween<double>(begin: 0, end: 0.5);
  final _expansionAnimation = Tween<double>(begin: 0, end: 1);

  late final AnimationController _animationController;
  late final Animation<double> _iconTurns;
  late final Animation<double> _expansion;

  bool _isExpanded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _iconTurns = _animationController.drive(_iconAnimation);
    _expansion = _animationController.drive(_expansionAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final strings = AppLocalizations.of(context)!;

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 16),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      buttonPadding: EdgeInsets.zero,
      backgroundColor: theme.cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SizedBox(
        width: 328,
        height: 544,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.howToGetCodeTitle,
                      style: theme.textTheme.px22.copyWith(height: 1.27),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      strings.howToGetCodeText,
                      style: theme.textTheme.px14.copyWith(height: 1.43),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      strings.address,
                      style: theme.textTheme.px14.copyWith(
                        color: theme.text?.withOpacity(0.6),
                        height: 1.43,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      strings.addressForCode,
                      style: theme.textTheme.px14.copyWith(height: 1.43),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: InkWell(
                  radius: 0,
                  onTap: _handleTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          strings.workMode,
                          style: theme.textTheme.px14.copyWith(
                            color: theme.text?.withOpacity(0.6),
                            height: 1.43,
                          ),
                        ),
                        RotationTransition(
                          turns: _iconTurns,
                          child: SvgPicture.asset(
                            ImageAssets.arrowDown,
                            color: theme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizeTransition(
                      sizeFactor: _expansion,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: WorkModeTable(),
                      ),
                    ),
                    Text(
                      strings.getWithYou,
                      style: theme.textTheme.px14.copyWith(
                        color: theme.text?.withOpacity(0.6),
                        height: 1.43,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Document(
                          text: strings.passport,
                        ),
                        const SizedBox(width: 8),
                        Document(
                          text: strings.pass,
                          color: theme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      strings.callBeforeCame,
                      style: theme.textTheme.px14.copyWith(color: theme.text?.withOpacity(0.6)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: PhoneButton(),
                    ),
                    Text(
                      '${strings.callAfter} 6 ${strings.hours}',
                      style: theme.textTheme.px14.copyWith(color: theme.red?.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            primary: theme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: Center(
            child: Text(
              strings.close,
              // TODO change textStyle
              style: theme.textTheme.px16.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.brightness == Brightness.light ? theme.white : theme.text,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleTap() {
    if (_isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}
