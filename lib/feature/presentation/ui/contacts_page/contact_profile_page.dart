import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/navigation_bar_bloc/navigation_bar_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/avatar_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/home/widgets/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactProfilePage extends StatelessWidget {
  final String id;

  const ContactProfilePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  void _contentInit(BuildContext context) {
    return BlocProvider.of<ContactsBloc>(context, listen: false)
        .add(FetchContactsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return BlocBuilder<NavigationBarBloc, NavigationBarState>(
      builder: (context, navState) {
        return BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is FetchContactsLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is FetchContactsLoadedState) {
              final ProfileEntity user = state.data.contacts.firstWhere(
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
                                  child: AvatarBox(
                                    size: 102,
                                    imgPath: user.photoLink,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                // Full name.
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${user.firstName} ${user.middleName}\n${user.lastName}',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                //-- Profile info --
                                // Post
                                _BuildInfo(
                                  headline:
                                      AppLocalizations.of(context)!.position,
                                  text: user.position.description,
                                ),

                                // Department.
                                _BuildInfo(
                                  headline:
                                      AppLocalizations.of(context)!.department,
                                  text: user.position.description,
                                ),

                                // Office phone.
                                _BuildInfo(
                                  headline: AppLocalizations.of(context)!
                                      .office_phone,
                                  text: user.phone.first.number,
                                ),

                                // Self phone.
                                _BuildInfo(
                                  headline:
                                      AppLocalizations.of(context)!.self_phone,
                                  text:
                                      '${user.phone[1].suffix} ${user.phone[1].number}',
                                ),

                                // Birth date.
                                _BuildInfo(
                                  headline:
                                      AppLocalizations.of(context)!.birth_date,
                                  text: user.birthday,
                                ),

                                // Email.
                                _BuildInfo(
                                  headline: AppLocalizations.of(context)!.email,
                                  text: user.email,
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

class _BuildInfo extends StatelessWidget {
  final String headline;
  final String text;

  /// Элемент информации.
  const _BuildInfo({
    Key? key,
    required this.headline,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: theme.textTheme.headline6,
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: theme.textTheme.headline5!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
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
