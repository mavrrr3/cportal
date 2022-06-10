import 'dart:developer';

import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_info_section.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
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
    final ThemeData theme = Theme.of(context);

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
          return SizedBox(
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
                      color: theme.hoverColor,
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
                        Align(
                          alignment: Alignment.center,
                          child: state.profile.photoLink != ''
                              ? AvatarBox(
                                  size: 102,
                                  imgPath: state.profile.photoLink,
                                  borderRadius: 24,
                                )
                              : EmptyAvatarBox(
                                  size: 102,
                                  borderRadius: 24,
                                  user: state.profile,
                                ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            state.profile.fullName,
                            style: theme.textTheme.headline4!.copyWith(
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
                          (i) => ProfileInfoSection(
                            headline: state.profile.contactInfo[i].type,
                            text: state.profile.contactInfo[i].contact,
                            bottomPadding: 18,
                          ),
                        ),

                        // Birth date.
                        if (state.profile.birthDayToString != null)
                          ProfileInfoSection(
                            headline: AppLocalizations.of(context)!.birth_date,
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
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      child: FocusableActionDetector(
        onShowHoverHighlight: onHover,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isAnimation ? theme.splashColor : theme.primaryColor,
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
                ? Border.all(color: theme.primaryColor, width: 2)
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
                  style: theme.textTheme.headline5!.copyWith(
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

  Color _getTextColor(ThemeData theme, bool isAnimation) {
    // ignore: prefer-conditional-expressions
    if (theme.brightness == Brightness.light) {
      return isAnimation ? theme.primaryColor : theme.splashColor;
    } else {
      return isAnimation ? theme.primaryColor : theme.hoverColor;
    }
  }
}
