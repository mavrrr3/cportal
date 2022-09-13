import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';

class FormatterUtil {
  static int pfoneWithoutMask({required String phone}) => int.parse(phone.replaceAll(
        RegExp('[^0-9]'),
        '',
      ));

  static String dayWithFullMonth({required DateTime date}) {
    return DateFormat('d MMMM', 'ru').format(date);
  }

  static String hoursAndMinutes({required DateTime date}) {
    return DateFormat('H:mm').format(date);
  }

  static String fullDateNumbers({required DateTime date}) {
    return DateFormat('d.MM.y').format(date);
  }

  static String dateWithExpirationDate({required DateTime date}) {
    return DateFormat('d MMMM', 'ru').format(date);
  }

  static String fullDateWithoutSeconds({required DateTime date}) {
    return DateFormat('d MMMM y, H:m', 'ru').format(date);
  }

  static String fullDate({required DateTime date}) {
    return DateFormat('d MMMM H:mm:s', 'ru').format(date);
  }

  static String expiredDays({
    required AppLocalizations localizedStrings,
    required DateTime date,
  }) {
    final difference = DateTime.now().difference(date).inDays;

    return '${localizedStrings.expiredPrefix} $difference ${getFormattedDaysExtraText(localizedStrings, difference)}';
  }

  // Адаптирует окончание, в зависимости от того, на сколько просрочена задача.
  static String getFormattedDaysExtraText(
    AppLocalizations localizedStrings,
    int query,
  ) {
    final div = query % 10;
    if (div == 1) {
      return localizedStrings.days1;
    } else if (div > 1 && div <= 4) {
      return localizedStrings.days2;
    } else {
      return localizedStrings.days3;
    }
  }
}
