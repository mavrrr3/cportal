import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/common/util/delayer.dart';
import 'package:cportal_flutter/common/util/custom_padding.dart';
import 'package:cportal_flutter/feature/presentation/ui/widgets/search_with_filter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ContactsSliverAppBar extends StatefulWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final Function() onSearchClear;
  final Function() onFilterTap;

  const ContactsSliverAppBar({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onSearchClear,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<ContactsSliverAppBar> createState() => _ContactsSliverAppBarState();
}

class _ContactsSliverAppBarState extends State<ContactsSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomTheme>()!;
    final delayer = Delayer(milliseconds: 500);
    final customPadding = CustomPadding(context);

    return SliverAppBar(
      toolbarHeight: 60,
      floating: true,
      elevation: 0,
      backgroundColor: theme.background,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: kIsWeb ? 12 : 11,
            ),
            Padding(
              padding: customPadding.getHorizontalPadding(),
              child: SearchWithFilter(
                searchController: widget.searchController,
                onSearch: (text) {
                  delayer.run(() => widget.onSearch(text));
                },
                onSearchClear: widget.onSearchClear,
                onFilterTap: widget.onFilterTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
