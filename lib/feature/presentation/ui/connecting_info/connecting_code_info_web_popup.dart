import 'package:cportal_flutter/common/theme/custom_theme.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_info/widgets/connecting_info_contacts_data.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_info/widgets/connecting_info_main_information.dart';
import 'package:cportal_flutter/feature/presentation/ui/connecting_info/widgets/work_mode_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ConnectingCodeInfoWebPopup extends StatelessWidget {
  const ConnectingCodeInfoWebPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomTheme theme = Theme.of(context).extension<CustomTheme>()!;
    final localizedStrings = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.42),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 43, right: 43, top: 193),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ConnectingInfoMainInformation(),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              localizedStrings.workMode,
                              style: theme.textTheme.px14.copyWith(
                                color: theme.text?.withOpacity(0.6),
                              ),
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 358),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 308,
                                  ),
                                  child: const WorkModeTable(),
                                ),
                                const SizedBox(height: 24),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 296,
                                  ),
                                  child: const ConnectingInfoContactsData(
                                    separator: SizedBox(height: 24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: context.pop,
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
