import 'package:intl/intl.dart';

extension EpocTimeFormat on int{
  String formatDate(String format){
    return DateFormat(format).format(DateTime.fromMillisecondsSinceEpoch(this));

  }
}