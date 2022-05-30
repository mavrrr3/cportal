import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/filter_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/navigation_route_names.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/favorites_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter_view_selected_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    _contentInit();
    super.initState();
  }

  // Во время инициализации запускается эвент и подгружается контент в зависимости от типа страницы.
  void _contentInit() {
    BlocProvider.of<ContactsBloc>(context, listen: false)
        .add(FetchContactsEvent());
    BlocProvider.of<FilterBloc>(context, listen: false)
        .add(FetchFiltersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        if (state is FetchContactsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FetchContactsLoadedState) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 7),
                  Padding(
                    padding: getHorizontalPadding(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Поиск.
                        SearchInput(
                          controller: _searchController,
                          onChanged: (text) {},
                        ),

                        // Фильтр.
                        _FilterButton(
                          onTap: () async {
                            await showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              builder: (context) => DraggableScrollableSheet(
                                expand: false,
                                snap: true,
                                initialChildSize: 0.57,
                                minChildSize: 0.57,
                                maxChildSize: 0.875,
                                builder: (context, scrollController) => Filter(
                                  scrollController: scrollController,
                                ),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 31),

                  // Выбранные фильтры.
                  Padding(
                    padding: getHorizontalPadding(context),
                    child: BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state is FilterLoadedState) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.filters.length,
                            itemBuilder: (context, index) {
                              // Выбран ли хоть один пункт в текущем разделе фильтра.
                              final bool isActive = state.filters[index].items
                                  .any((element) => element.isActive);

                              // Если isActive - создаем список только с выбранными пунктами в текущем разделе.
                              final List<FilterItemEntity> selectedItems = [];
                              if (isActive) {
                                for (final item in state.filters[index].items) {
                                  if (item.isActive) {
                                    selectedItems.add(item);
                                  }
                                }
                              }

                              // Рендеринг.
                              return isActive
                                  ? FilterViewSelectedRow(
                                      headline: state.filters[index].headline,
                                      selectedItems: selectedItems,
                                      onClose: (item) {
                                        setState(() {
                                          BlocProvider.of<FilterBloc>(context)
                                              .add(
                                            FilterRemoveItemEvent(
                                              filterIndex: index,
                                              item: item,
                                            ),
                                          );
                                        });
                                      },
                                    )
                                  : const SizedBox();
                            },
                          );
                        }

                        // TODO: Обработать другие стейты.
                        return const SizedBox();
                      },
                    ),
                  ),

                  // Избранные.
                  if (state.data.favorites.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 16,
                        top: 8,
                      ),
                      child: SizedBox(
                        height: 48,
                        child: FavoritesRow(
                          items: state.data.favorites,
                          onTap: (i) => _goToUserPage(state, i),
                        ),
                      ),
                    ),

                  // Колонка контактов.
                  Padding(
                    padding: getHorizontalPadding(context),
                    child: ContactsList(
                      items: state.data.contacts,
                      onTap: (i) => _goToUserPage(state, i),
                    ),
                  ),

                  const SizedBox(height: 42),
                ],
              ),
            ),
          );
        }

        // TODO: Отработать другие стейты
        return const SizedBox();
      },
    );
  }

  void _goToUserPage(
    FetchContactsLoadedState state,
    int i,
  ) =>
      GoRouter.of(context).pushNamed(
        NavigationRouteNames.contactProfile,
        params: {'fid': state.data.contacts[i].id},
        extra: state.data.contacts[i],
      );
}

class _FilterButton extends StatelessWidget {
  final Function()? onTap;

  const _FilterButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.splashColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            'assets/icons/filter.svg',
            color: theme.cardColor.withOpacity(0.68),
          ),
        ),
      ),
    );
  }
}
