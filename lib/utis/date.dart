import 'package:intl/intl.dart';

String convertMilisecToDateTimeReadable(int mi, DateFormat dateFormat) =>
    dateFormat.format(DateTime.fromMillisecondsSinceEpoch(mi));
