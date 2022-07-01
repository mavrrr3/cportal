import 'package:cportal_flutter/common/custom_theme.dart';
import 'package:cportal_flutter/feature/data/datasources/filter_datasource/filter_local_datasource.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_event.dart';
import 'package:cportal_flutter/feature/presentation/bloc/contacts_bloc/contacts_state.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_contacts_bloc/filter_contacts_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_declarations_bloc/filter_declarations_bloc.dart';
import 'package:cportal_flutter/feature/presentation/bloc/filter_bloc/filter_event.dart';
import 'package:cportal_flutter/feature/presentation/ui/declarations_page/declarations_page_content.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_mobile.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/filter/filter_web.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/menu/desktop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DeclarationsPage extends StatefulWidget {
  const DeclarationsPage({Key? key}) : super(key: key);

  @override
  State<DeclarationsPage> createState() => _DeclarationsPageState();
}

class _DeclarationsPageState extends State<DeclarationsPage> {
  late bool _isFilterOpenWeb;

  @override
  void initState() {
    _isFilterOpenWeb = false;
    _contentInit();
    super.initState();
  }

  // Во время инициализации запускается эвент и подгружаются контакты и фильтры.
  void _contentInit() {
    BlocProvider.of<ContactsBloc>(context, listen: false).add(const FetchContactsEvent());
    BlocProvider.of<FilterDeclarationsBloc>(context, listen: false).add( FetchFiltersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;

    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: theme.background,
            body: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveVisibility(
                      visible: false,
                      visibleWhen: const [
                        Condition<dynamic>.largerThan(name: MOBILE),
                      ],
                      // Меню Web.
                      child: DesktopMenu(
                        currentIndex: 4,
                        onChange: (index) => changePage(context, index),
                      ),
                    ),
                    if (state is ContactsLoadingState)
                      const Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    if (state is ContactsLoadedState)
                      DeclarationsPageContent(
                        onFilterTap: () async {
                          if (!ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
                            await showFilterMobile(
                              context,
                              onApply: _onApplyFilter,
                              onClear: _onClearFilter,
                              type: FilterType.declarations,
                            );
                          } else {
                            setState(() {
                              _isFilterOpenWeb = true;
                            });
                          }
                        },
                      ),
                  ],
                ),
                if (_isFilterOpenWeb)
                  GestureDetector(
                    onTap: () => setState(() {
                      _isFilterOpenWeb = false;
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: theme.barrierColor,
                    ),
                  ),
                if (_isFilterOpenWeb)
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilterWeb(
                      onApply: _onApplyFilter,
                      onClear: _onClearFilter,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onApplyFilter() {
    if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
      setState(() {
        _isFilterOpenWeb = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _onClearFilter() {
    BlocProvider.of<FilterContactsBloc>(
      context,
    ).add(FilterRemoveAllEvent());
  }
}
