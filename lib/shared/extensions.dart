import 'package:internet_of_tomato_farming/pages/models/notification.model.dart';
import 'package:intl/intl.dart';

extension DateTimeToDateInt on DateTime {
  int toDateInt(){
    String dateString = DateFormat("yyyyMMddHHmmss").format(this);
    int dateInt = int.parse(dateString);
    return dateInt;
  }
}

extension DateTimeForNotification on DateTime{
  String toNotificationFormat(){
    Duration diff = DateTime.now().difference(this);

    if(diff.inDays >= 30) {
      return DateFormat('dd/MM/y HH:mm').format(this);
    }else if(diff.inDays >= 7) {
      return DateFormat('dd MMM HH:mm').format(this);
    }else if(diff.inDays >= 2) {
      return DateFormat('EEEE HH:mm').format(this);
    }else if(diff.inDays >= 1){
      return 'Yesterday '+DateFormat('HH:mm').format(this);
    }else if(diff.inHours >= 1){
      return '${diff.inHours} hour(s) ago';
    } else if(diff.inMinutes >= 1){
      return '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1){
      return '${diff.inSeconds} second(s) ago';
    } else {
      return 'Just now';
    }
  }
}

extension GetById on List<NotificationModel> {
  int indexOfId(int id){
    for(int i = 0; i < length; i++){
      if(this[i].id == id) return i;
    }
    return -1;
  }
}