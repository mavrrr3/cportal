import 'package:intl/intl.dart';

class DateTimeUtil {
  static String getFormattedDate(DateTime dateTime) {
    final date = dateTime.toLocal();
    final currentDate = DateTime.now();
    if (date.year != currentDate.year) {
      return DateFormat('dd.MM.yy').format(date);
    } else if (date.day != currentDate.day) {
      return DateFormat('d MMMM', 'ru').format(date);
    }

    return DateFormat('hh:mm').format(date);
  }
}
