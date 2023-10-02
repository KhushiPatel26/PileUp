String formatDate(DateTime dateTime) {
  String formattedDate = "${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)} " +
      "${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}:${_twoDigits(dateTime.second)}.${_microseconds(dateTime.microsecond)}";

  return formattedDate;
}

String _twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  }
  return "0$n";
}

String _microseconds(int n) {
  if (n < 10) {
    return "00000$n";
  } else if (n < 100) {
    return "0000$n";
  } else if (n < 1000) {
    return "000$n";
  } else if (n < 10000) {
    return "00$n";
  } else if (n < 100000) {
    return "0$n";
  } else {
    return "$n";
  }
}
