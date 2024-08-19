import 'package:intl/intl.dart';

String formatDateDMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyyy").format(dateTime);
}
