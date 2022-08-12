import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/get_single_profile_bloc/get_single_profile_state.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile_data/widgets/phone_box.dart';
import 'package:cportal_flutter/feature/presentation/ui/profile_data/widgets/profile_data_item.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/layout/layout_with_app_bar.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/platform_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileDataScreen extends StatefulWidget {
  final String id;

  const ProfileDataScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetSingleProfileBloc>().add(
          GetSingleProfileEventImpl(
            widget.id,
            isMyProfile: true,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final localizedStrings = AppLocalizations.of(context)!;
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final bottomIndent = bottomPadding == 0 ? 16.0 : bottomPadding;

    return LayoutWithAppBar(
      title: localizedStrings.yourData,
      child: BlocBuilder<GetSingleProfileBloc, GetSingleProfileState>(
        builder: (context, state) {
          if (state is GetSingleProfileLoadedState) {
            final ProfileEntity profile = state.profile;

            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        PhoneBox(phoneNumber: profile.personalPhoneNumber),
                        const SizedBox(height: 24),
                        ProfileDataItem(
                          title: localizedStrings.position,
                          description: profile.position,
                        ),
                        const SizedBox(height: 8),
                        ProfileDataItem(
                          title: localizedStrings.department,
                          description: profile.department,
                        ),
                        const SizedBox(height: 8),
                        if (profile.birthDayToString != null)
                          ProfileDataItem(
                            title: localizedStrings.birthDay,
                            description: profile.birthDayToString!,
                          ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 20),
                        PhoneBox(phoneNumber: profile.personalPhoneNumber),
                        const SizedBox(height: 24),
                        ProfileDataItem(
                          title: localizedStrings.position,
                          description: profile.position,
                        ),
                        const SizedBox(height: 8),
                        ProfileDataItem(
                          title: localizedStrings.department,
                          description: profile.department,
                        ),
                        const SizedBox(height: 8),
                        if (profile.birthDayToString != null)
                          ProfileDataItem(
                            title: localizedStrings.birthDay,
                            description: profile.birthDayToString!,
                          ),
                        const SizedBox(height: 8),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: bottomIndent),
                          shrinkWrap: true,
                          itemCount: profile.contactInfo.length,
                          itemBuilder: (context, index) {
                            final contactData = profile.contactInfo[index];

                            return ProfileDataItem(
                              title: contactData.type,
                              description: contactData.contact,
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                        ),
                        // Space under button.
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: bottomIndent,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      primary: theme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    // TODO Implement function of save new phone number.
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        localizedStrings.saveChanges,
                        style: theme.textTheme.px16Bold.copyWith(
                          color: theme.brightness == Brightness.light ? theme.white : theme.text,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: PlatformProgressIndicator());
        },
      ),
    );
  }
}
