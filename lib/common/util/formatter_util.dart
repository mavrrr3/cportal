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
    final timeFormatter = DateFormat('d MMMM H:mm:ms', 'ru');

    return timeFormatter.format(date);
  }
}
