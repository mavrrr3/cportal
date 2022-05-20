import 'package:cportal_flutter/common/util/padding.dart';
import 'package:cportal_flutter/feature/domain/entities/profile_entity.dart';
import 'package:cportal_flutter/feature/presentation/go_navigation.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts/widgets/contacts_list.dart';
import 'package:cportal_flutter/feature/presentation/ui/contacts/widgets/favorites.dart';
import 'package:cportal_flutter/feature/presentation/ui/main_page/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

final List<ProfileEntity> _contacts = [
  ProfileEntity(
    id: '111',
    externalId: '111',
    firstName: 'Суханенков',
    middleName: 'Владимир',
    lastName: 'Константинович',
    birthday: '18.07.1989',
    email: 'email@example.com',
    photoLink:
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Директор мобильных решений'),
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
    birthday: '18.07.1989',
    email: 'email@example.com',
    photoLink:
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов'),
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
    birthday: '18.07.1989',
    email: 'email@example.com',
    photoLink:
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '', department: 'Новосталь-М', description: 'Начальник отдела'),
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
    birthday: '18.07.1989',
    email: 'email@example.com',
    photoLink:
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов'),
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
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов'),
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
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов'),
    phone: const [],
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
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов'),
    phone: const [],
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
        'https://kartinkin.net/uploads/posts/2021-03/1616044597_16-p-fon-shrek-17.jpg',
    active: true,
    position: const PositionEntity(
        id: '',
        department: 'Новосталь-М',
        description: 'Руководитель проектов'),
    phone: const [],
    userCreated: 'userCreated',
    dateCreated: DateTime.now(),
    userUpdate: 'userUpdate',
    dateUpdated: DateTime.now(),
  ),
];

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  SearchInput(
                    controller: _searchController,
                    onChanged: (text) {},
                  ),
                  _FilterButton(
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 31,
            ),

            // Favorites
            if (_contacts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: SizedBox(
                    height: 48,
                    child: FavoritesRow(items: _contacts, onTap: (i) {})),
              ),

            // Contacts Column
            Padding(
              padding: getHorizontalPadding(context),
              child: ContactsList(
                items: _contacts,
                onTap: (i) {
                  GoRouter.of(context).pushNamed(
                    NavigationRouteNames.contactProfile,
                    params: {'fid': _contacts[i].id},
                    extra: _contacts[i],
                  );
                },
              ),
            ),

            const SizedBox(height: 42),
          ],
        ),
      ),
    );
  }
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
