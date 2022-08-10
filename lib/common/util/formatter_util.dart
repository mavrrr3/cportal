import 'package:intl/intl.dart';

class FormatterUtil {
  static int pfoneWithoutMask({required String phone}) =>
      int.parse(phone.replaceAll(
        RegExp('[^0-9]'),
        '',
      ));

  // Заявления.
  static String declarationsHistoryDate({required DateTime date}) {
    final timeFormatter = DateFormat('d MMMM', 'ru');

    return timeFormatter.format(date);
  }

  static String declarationCardTime({required DateTime date}) {
    final timeFormatter = DateFormat('H:mm');

    return timeFormatter.format(date);
  }

  static String declarationCardExpiresDate({required DateTime date}) {
    final timeFormatter = DateFormat('d.MM.y');

    return timeFormatter.format(date);
  }
  //
}
