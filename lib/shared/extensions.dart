import 'package:intl/intl.dart';

extension DateTimeToDateInt on DateTime {
  int toDateInt(){
    String dateString = DateFormat("yyyyMMddHHmmss").format(this);
    int dateInt = int.parse(dateString);
    return dateInt;
  }
}