import 'package:intl/intl.dart';

class TimeFormat{
  static String  currentTime(myDateTime) {
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    var utcDate   = dateFormat.format(DateTime.parse(myDateTime));
    DateTime dateTime= dateFormat.parse(utcDate,true);
    return DateFormat('dd MMM, hh:mm').format(dateTime);
  }

  static String convertInDate(date){
    DateTime dateTime = DateTime.parse(date);

    // Format the date
    return DateFormat('yyyy MMMM').format(dateTime);
  }

  static String convertInTime(timeString){
    DateTime time = DateFormat('HH:mm:ss').parse(timeString);
    // Format the date
    return DateFormat('ha').format(time);
  }
}