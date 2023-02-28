import 'package:intl/intl.dart' as intl;
import 'package:meta/meta.dart';

@sealed
abstract class DateUtil {
  DateUtil._();

  /// Format date
  static String format(DateTime? date, [intl.DateFormat? format]) {
    if (date == null) return '';
    if (format != null) return format.format(date);
    final now = DateTime.now();
    final today = now.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    if (date.isAfter(today)) return intl.DateFormat.Hms().format(date);
    if (date.isAfter(today.subtract(const Duration(days: 7)))) {
      return intl.DateFormat(intl.DateFormat.WEEKDAY).format(date);
    }
    return intl.DateFormat.yMd().format(date);
  }
}
