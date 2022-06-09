import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';

class ContactProfilePage extends StatelessWidget {
  final String id;

  const ContactProfilePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  void _contentInit(BuildContext context) {
    return BlocProvider.of<ContactsBloc>(context, listen: false)
        .add(const FetchContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(const GetSingleProfileEventImpl('A1B2C3D4E5'));
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, navState) {
        return BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ContactsLoadedState) {
              final ProfileEntity user = state.contacts.firstWhere(
                (element) => element.id == id,
              );

              return Swipe(
                onSwipeRight: () {
                  if (kIsWeb) {
                    _contentInit(context);
                  }
                  _onBack(context);
                },
                child: Scaffold(
                  bottomNavigationBar: !kIsWeb
                      ? CustomBottomBar(
                          state: navState,
                          isNestedNavigation: true,
                        )
                      : null,
                  body: Stack(
                    children: [
                      // Action buttons.
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Call.
                              _ActionButton(
                                img: 'assets/icons/phone.svg',
                                onTap: () {},
                              ),
                              const SizedBox(width: 16),

                              // Message.
                              _ActionButton(
                                img: 'assets/icons/message.svg',
                                onTap: () {},
                              ),
                              const SizedBox(width: 16),

                              // Send email.
                              _ActionButton(
                                img: 'assets/icons/email.svg',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Content.
                      SingleChildScrollView(
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Back button.
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _BackButton(
                                      onTap: () {
                                        if (kIsWeb) {
                                          _contentInit(context);
                                        }
                                        _onBack(context);
                                      },
                                    ),
                                    const SizedBox(width: 24),
                                  ],
                                ),
                                const SizedBox(height: 41),

                                // Profile image.
                                Align(
                                  alignment: Alignment.center,
                                  child: user.photoLink != ''
                                      ? AvatarBox(
                                          size: 102,
                                          imgPath: user.photoLink,
                                          isApiImg: false,
                                          borderRadius: 24,
                                        )
                                      : EmptyAvatarBox(
                                          size: 102,
                                          borderRadius: 24,
                                          user: user,
                                        ),
                                ),
                                const SizedBox(height: 12),

                                // Full name.
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    user.fullName,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                //-- Profile info --
                                // Post
                                ProfileInfoSection(
                                  headline:
                                      AppLocalizations.of(context)!.position,
                                  text: user.position,
                                  bottomPadding: 21,
                                ),

                                // Department.
                                ProfileInfoSection(
                                  headline:
                                      AppLocalizations.of(context)!.department,
                                  text: user.department,
                                  bottomPadding: 21,
                                ),

                                // Contact info.
                                ...List.generate(
                                  user.contactInfo.length,
                                  (i) => ProfileInfoSection(
                                    headline: user.contactInfo[i].type,
                                    text: user.contactInfo[i].contact,
                                    bottomPadding: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ContactsEmptyState) {
              _contentInit(context);
            }

            // TODO: Отработать другие стейты.
            return const SizedBox();
          },
        );
      },
    );
  }

  void _onBack(BuildContext context) => context.pop();
}

class _BackButton extends StatelessWidget {
  final Function() onTap;

  const _BackButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/icons/back_arrow.svg',
            color: theme.cardColor,
            width: 16,
          ),
          const SizedBox(
            width: 48,
            height: 24,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String img;
  final Function onTap;

  /// Кнопка взаимодействия с Юзером [Звонок, Чат, Почта].
  const _ActionButton({
    Key? key,
    required this.img,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(16.8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(
          img,
          width: 24,
        ),
      ),
    );
  }
}
