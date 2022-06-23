import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/profile_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class ContactProfilePopUp extends StatefulWidget {
  final String id;
  const ContactProfilePopUp({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ContactProfilePopUp> createState() => _ContactProfilePopUpState();
}

class _ContactProfilePopUpState extends State<ContactProfilePopUp> {
  late bool _isButtonHover;
  @override
  void initState() {
    _isButtonHover = false;
    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(GetSingleProfileEventImpl(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
      builder: (context, state) {
        if (state is GetSingleProfileLoadingState) {
          return const SizedBox(
            width: 491,
            height: 660,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is GetSingleProfileLoadedState) {
          return Material(
            color: theme.cardColor,
            child: SizedBox(
              height: 660,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: theme.textLight,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image & Full Name.
                          ProfileImage(user: state.profile, size: 102, borderRadius: 24,),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              state.profile.fullName,
                              style: theme.textTheme.px17.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // -- Profile info --
                          // Post.
                          ProfileInfoSection(
                            headline: AppLocalizations.of(context)!.position,
                            text: state.profile.position,
                            bottomPadding: 18,
                          ),

                          // Department.
                          ProfileInfoSection(
                            headline: AppLocalizations.of(context)!.department,
                            text: state.profile.department,
                            bottomPadding: 18,
                          ),

                          // Contact info.
                          ...List.generate(
                            state.profile.contactInfo.length,
                            (i){
                            return
                            
                             ProfileInfoSection(
                              headline: state.profile.contactInfo[i].type,
                              text: state.profile.contactInfo[i].contact,
                              bottomPadding: 18,
                              isEmail: state.profile.contactInfo[i].type == 'Эл. почта',
                            ) ;

                            } ,
                            
                          ),

                          // Birth date.
                          if (state.profile.birthDayToString != null)
                            ProfileInfoSection(
                              headline:
                                  AppLocalizations.of(context)!.birth_date,
                              text: state.profile.birthDayToString!,
                              bottomPadding: 0,
                            ),
                        ],
                      ),
                      _ActionButton(
                        onTap: () {},
                        onHover: _handleHoveHighlight,
                        isAnimation: _isButtonHover,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        // TODO: Отработать другие стейты.

        return const SizedBox();
      },
    );
  }

  void _handleHoveHighlight(bool value) {
    setState(() {
      _isButtonHover = value;
    });
  }
}

class _ActionButton extends StatelessWidget {
  final Function() onTap;
  final Function(bool) onHover;
  final bool isAnimation;

  // Кнопка взаимодействия с пользователем [Перейти в Чат].
  const _ActionButton({
    Key? key,
    required this.onTap,
    required this.onHover,
    required this.isAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      child: FocusableActionDetector(
        onShowHoverHighlight: onHover,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isAnimation ? theme.cardColor : theme.primary,
            boxShadow: isAnimation
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 7,
                    ),
                  ]
                : null,
            border: isAnimation
                ? Border.all(color: theme.primary!, width: 2)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/message.svg',
                  width: 24,
                  color: _getTextColor(theme, isAnimation),
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.go_to_chat,
                  style: theme.textTheme.px16.copyWith(
                    fontWeight: FontWeight.w700,
                    color: _getTextColor(theme, isAnimation),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getTextColor(CustomTheme theme, bool isAnimation) {
    // ignore: prefer-conditional-expressions
    if (theme.brightness == Brightness.light) {
      return isAnimation ? theme.primary! : theme.cardColor!;
    } else {
      return isAnimation ? theme.primary! : theme.textLight!;
    }
  }
}
