import 'dart:developer';

import 'package:cportal_flutter/common/constants/image_assets.dart';
import 'package:cportal_flutter/common/constants/uri_schemes.dart';
import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/formatter_util.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/profile_image.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/profile_info_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/custom_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swipe/swipe.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactProfilePage extends StatefulWidget {
  final String id;

  const ContactProfilePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ContactProfilePage> createState() => _ContactProfilePageState();
}

class _ContactProfilePageState extends State<ContactProfilePage> {
  @override
  void initState() {
    BlocProvider.of<GetSingleProfileBloc>(
      context,
      listen: false,
    ).add(GetSingleProfileEventImpl(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return Swipe(
      onSwipeRight: () {
        if (kIsWeb) {
          _previousContentInit(context);
        }
        _onBack(context);
      },
      child: Scaffold(
        backgroundColor: theme.background,
        body: BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
          builder: (context, state) {
            if (state is GetSingleProfileLoadingState) {
              return const Center(
                child: PlatformProgressIndicator(),
              );
            }

            if (state is GetSingleProfileLoadedState) {
              final ProfileEntity user = state.profile;

              return Stack(
                children: [
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _BackButton(
                                  onTap: () {
                                    if (kIsWeb) {
                                      _previousContentInit(context);
                                    }
                                    _onBack(context);
                                  },
                                ),
                                const SizedBox(width: 24),
                              ],
                            ),
                            const SizedBox(height: 41),

                            // Profile image.
                            ProfileImage(
                              fullName: user.fullName,
                              imgLink: user.photoLink,
                              color: user.color,
                              size: 102,
                              borderRadius: 24,
                            ),
                            const SizedBox(height: 12),

                            // Full name.
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                user.fullName,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.px17.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            //-- Profile info --
                            // Post.
                            ProfileInfoSection(
                              headline: AppLocalizations.of(context)!.position,
                              text: user.position,
                              bottomPadding: 19,
                            ),

                            // Department.
                            ProfileInfoSection(
                              headline:
                                  AppLocalizations.of(context)!.department,
                              text: user.department,
                              bottomPadding: 19,
                            ),

                            // Birthday.
                            if (user.birthDayToString != null)
                              ProfileInfoSection(
                                headline:
                                    AppLocalizations.of(context)!.birth_date,
                                text: user.birthDayToString!,
                                bottomPadding: 19,
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
                            img: ImageAssets.phone,
                            onTap: () async {
                              final phoneWithOutMask =
                                  FormatterUtil.pfoneWithoutMask(
                                phone: state.getPhone,
                              );
                              log(phoneWithOutMask.toString());

                              final Uri telLauncher = Uri(
                                scheme: UriSchemes.tel,
                                path: '+$phoneWithOutMask',
                              );
                              // final Uri telLauncher = Uri(
                              //   scheme: UriSchemes.tel,
                              //   path: '123456',
                              // );
                              log('$telLauncher');

                              await launchUrl(telLauncher);
                            },
                          ),
                          const SizedBox(width: 16),

                          // Message.
                          _ActionButton(
                            img: ImageAssets.message,
                            onTap: () async {
                              final phoneWithOutMask =
                                  FormatterUtil.pfoneWithoutMask(
                                phone: state.getPhone,
                              );
                              final Uri smsLauncher = Uri(
                                scheme: UriSchemes.sms,
                                path: '$phoneWithOutMask',
                              );
                              log('$smsLauncher');

                              await launchUrl(smsLauncher);
                            },
                          ),
                          const SizedBox(width: 16),

                          // Send email.
                          _ActionButton(
                            img: ImageAssets.email,
                            onTap: () async {
                              final Uri emailLauncher = Uri(
                                scheme: UriSchemes.mail,
                                path: state.getEmail,
                              );
                              log('$emailLauncher');
                              await launchUrl(emailLauncher);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is ContactsEmptyState) {
              _previousContentInit(context);
            }

            // TODO: Отработать другие стейты.
            return const SizedBox();
          },
        ),
        bottomNavigationBar:
            !kIsWeb ? const CustomBottomBar(isNestedNavigation: true) : null,
      ),
    );
  }

  void _previousContentInit(BuildContext context) {
    return BlocProvider.of<ContactsBloc>(context, listen: false)
        .add(const FetchContactsEvent());
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
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Stack(
        children: [
          SvgPicture.asset(
            ImageAssets.backArrow,
            color: theme.text,
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
  final Function() onTap;

  /// Кнопка взаимодействия с Юзером [Звонок, Чат, Почта].
  const _ActionButton({
    Key? key,
    required this.img,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.primary,
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
      ),
    );
  }
}
