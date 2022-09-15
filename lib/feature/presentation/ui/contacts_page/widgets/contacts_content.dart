import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/is_larger_then.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/contact_profile_pop_up.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/selected_filters_view.dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ContactsContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function() sendFilters;
  const ContactsContent({
    Key? key,
    required this.scrollController,
    required this.sendFilters,
  }) : super(key: key);

  @override
  State<ContactsContent> createState() => _ContactsContentState();
}

class _ContactsContentState extends State<ContactsContent> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Выбранные фильтры.
          BlocBuilder<FilterContactsBloc, FilterState>(
            builder: (context, state) {
              if (state is FilterLoadedState) {
                return SelectedFiltersView(
                  filters: state.contactsFilters,
                  onRemove: (item, i) async {
                    context.read<FilterContactsBloc>().add(
                          FilterRemoveItemEvent(
                            filterIndex: i,
                            item: item,
                          ),
                        );
                    await Future<dynamic>.delayed(
                      const Duration(milliseconds: 150),
                    );
                    widget.sendFilters();
                  },
                );
              }

              // TODO: отработать другие стейты.
              return const SizedBox(height: 31);
            },
          ),

          BlocBuilder<ContactsBloc, ContactsState>(
            builder: (context, state) {
              List<ProfileEntity> contacts = [];
              if (state is ContactsLoadingState && state.isFirstFetch) {
                return const SizedBox();
              } else if (state is ContactsLoadingState) {
                contacts = state.oldContacts;
              }

              if (state is ContactsLoadedState) {
                contacts = state.contacts;
              }

              return contacts.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// [Не удалять, нужная фича]
                        // Избранные.
                        // if (state.favorites.isNotEmpty)
                        //   Padding(
                        //     padding: EdgeInsets.only(
                        //       left: getSingleHorizontalPadding(
                        //         context,
                        //       ),
                        //       bottom: 16,
                        //     ),
                        //     child: Favorites(
                        //       items: state.favorites,
                        //       onTap: (i) async {
                        //         await _goToUserPage(
                        //           contacts,
                        //           i,
                        //         );
                        //       },
                        //     ),
                        //   ),

                        // Рендеринг контактов.
                        ContactsList(
                          items: contacts,
                          onTap: (i) async {
                            await _goToUserPage(context, contacts, i);
                          },
                        ),

                        const SizedBox(height: 42),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.emptySearch,
                          style: theme.textTheme.px22.copyWith(
                            color: theme.text?.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }

  // Навигация на страницу пользователя.
  Future<void> _goToUserPage(
    BuildContext context,
    List<ProfileEntity> contacts,
    int i,
  ) async {
    if (isDesktop(context)) {
      await _showContactProfile(context, contacts, i);
    } else {
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.contactProfile,
        params: {'fid': contacts[i].id},
      );
    }
  }

  // Профиль пользователя для Web.
  Future<void> _showContactProfile(
    BuildContext context,
    List<ProfileEntity> contacts,
    int i,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

        return StatefulBuilder(
          builder: (context, setState) {
            final width = MediaQuery.of(context).size.width;

            return Center(
              child: Container(
                width: width * 0.3,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: ContactProfilePopUp(id: contacts[i].id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
