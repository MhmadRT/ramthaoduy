import 'package:intl/intl.dart';
import 'package:ramtha/helper/time_ago.dart'as timeago;
class ConstVars {
  static final DateFormat format = DateFormat('dd/MM/yyyy', 'ar');

  static String timeAgo(DateTime? time) {
    if (time == null) return '';
    return timeago.format(time,locale: 'ar');
  }
}
