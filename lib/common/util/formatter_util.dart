import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:intl/intl.dart';

class FormatterUtil {
  static int pfoneWithoutMask({required String phone}) =>
      int.parse(phone.replaceAll(
        RegExp('[^0-9]'),
        '',
      ));

  static String dayWithFullMonth({required DateTime date}) {
    final timeFormatter = DateFormat('d MMMM', 'ru');

    return timeFormatter.format(date);
  }

  static String hoursAndMinutes({required DateTime date}) {
    final timeFormatter = DateFormat('H:mm');

    return timeFormatter.format(date);
  }

  static String fullDateNumbers({required DateTime date}) {
    final timeFormatter = DateFormat('d.MM.y');

    return timeFormatter.format(date);
  }

  static String dateWithExpirationDate({required DateTime date}) {
    final timeFormatter = DateFormat('d MMMM', 'ru');

    return timeFormatter.format(date);
  }

  static String fullDate({required DateTime date}) {
    final timeFormatter = DateFormat('d MMMM H:mm:s', 'ru');

    return timeFormatter.format(date);
  }

  static String expiredDays({
    required AppLocalizations strings,
    required DateTime date,
  }) {
    final currentDate = DateTime.now();
    final difference = currentDate.difference(date).inDays;

    return '${strings.expiredPrefix} $difference ${getFormattedDaysExtraText(strings, difference)}';
  }

  // Адаптирует окончание, в зависимости от того, на сколько просрочена задача.
  static String getFormattedDaysExtraText(
    AppLocalizations strings,
    int query,
  ) {
    final div = query % 10;
    if (div == 1) {
      return strings.days1;
    } else if (div > 1 && div <= 4) {
      return strings.days2;
    } else {
      return strings.days3;
    }
  }
}
