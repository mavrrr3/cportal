import 'dart:developer';

import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_state.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/favorites.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/filter_view_selected_row.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts_page/widgets/tag_container.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

final List<ProfileEntity> _contacts = [
  ProfileEntity(
    id: '111',
    externalId: '111',
    firstName: 'Суханенков',
    middleName: 'Владимир',
    lastName: 'Константинович',
    birthday: 'birthday',
    email: 'email',
    photoLink:
        'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png',
    active: true,
    position: const PositionEntity(
      id: '',
      department: 'Новосталь-М',
      description: 'Руководитель проектов',
    ),
    phone: const [
      PhoneEntity(
        number: '76-56-67',
        suffix: '',
        primary: false,
      ),
      PhoneEntity(
        number: '923 456 67 78',
        suffix: '+7',
        primary: false,
      ),
    ],
    userCreated: 'userCreated',
    dateCreated: DateTime.now(),
    userUpdate: 'userUpdate',
    dateUpdated: DateTime.now(),
  ),
  ProfileEntity(
    id: '111',
    externalId: '111',
    firstName: 'Суханенков',
    middleName: 'Владимир',
    lastName: 'Константинович',
    birthday: 'birthday',
    email: 'email',
    photoLink:
        'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png',
    active: true,
    position: const PositionEntity(
      id: '',
      department: 'Новосталь-М',
      description: 'Руководитель проектов',
    ),
    phone: const [
      PhoneEntity(
        number: '76-56-67',
        suffix: '',
        primary: false,
      ),
      PhoneEntity(
        number: '923 456 67 78',
        suffix: '+7',
        primary: false,
      ),
    ],
    userCreated: 'userCreated',
    dateCreated: DateTime.now(),
    userUpdate: 'userUpdate',
    dateUpdated: DateTime.now(),
  ),
  ProfileEntity(
    id: '111',
    externalId: '111',
    firstName: 'Суханенков',
    middleName: 'Владимир',
    lastName: 'Константинович',
    birthday: 'birthday',
    email: 'email',
    photoLink:
        'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png',
    active: true,
    position: const PositionEntity(
      id: '',
      department: 'Новосталь-М',
      description: 'Руководитель проектов',
    ),
    phone: const [
      PhoneEntity(
        number: '76-56-67',
        suffix: '',
        primary: false,
      ),
      PhoneEntity(
        number: '923 456 67 78',
        suffix: '+7',
        primary: false,
      ),
    ],
    userCreated: 'userCreated',
    dateCreated: DateTime.now(),
    userUpdate: 'userUpdate',
    dateUpdated: DateTime.now(),
  ),
];

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
    BlocProvider.of<FilterBloc>(context, listen: false).add(FilterInitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
                  // Поиск
                  SearchInput(
                    controller: _searchController,
                    onChanged: (text) {},
                  ),

                  // Фильтр
                  _FilterButton(
                    onTap: () async {
                      await showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
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

            // Выбранные фильтры
            Padding(
              padding: getHorizontalPadding(context),
              child: BlocBuilder<FilterBloc, FilterStateImpl>(
                builder: (context, state) {
                  return state.filters != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.filters!.length,
                          itemBuilder: ((context, index) {
                            // Выбран ли хоть один пункт в текущем разделе фильтра
                            final bool isActive = state.filters![index].items
                                .any((element) => element.isActive);

                            // если isActive - создаем список только с выбранными пунктами в текущем разделе
                            List<FilterItemModel> selectedItems = [];
                            if (isActive) {
                              for (var item in state.filters![index].items) {
                                if (item.isActive) {
                                  selectedItems.add(item);
                                }
                              }
                            }

                            // Рендеринг
                            return isActive
                                ? FilterViewSelectedRow(
                                    headline: state.filters![index].headline,
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
                          }),
                        )
                      : const SizedBox();
                },
              ),
            ),

            // Избранные
            if (_contacts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                  top: 8,
                ),
                child: SizedBox(
                  height: 48,
                  child: FavoritesRow(
                    items: _contacts,
                    onTap: (i) => _goToUserPage(i),
                  ),
                ),
              ),

            // Колонка контактов
            Padding(
              padding: getHorizontalPadding(context),
              child: ContactsList(
                items: _contacts,
                onTap: (i) => _goToUserPage(i),
              ),
            ),

            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }

  void _goToUserPage(int i) => GoRouter.of(context).pushNamed(
        NavigationRouteNames.contactProfile,
        params: {'fid': _contacts[i].id},
        extra: _contacts[i],
      );
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

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
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/filter.svg',
            color: theme.cardColor.withOpacity(0.68),
          ),
        ),
      ),
    );
  }
}
