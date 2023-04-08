String convertDayOfWeek(int day) {
  switch (day) {
    case 1:
      return "Th 2";
    case 2:
      return "Th 3";
    case 3:
      return "Th 4";
    case 4:
      return "Th 5";
    case 5:
      return "Th 6";
    case 6:
      return "Th 7";
  }
  return "CN";
}

String getDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year} (${convertDayOfWeek(date.weekday)})";
}

String getMonth(DateTime date) {
  return "${date.month}/${date.year} (1/${date.month} - ${getLastDateOfMonth(date)}/${date.month})";
}

int getLastDateOfMonth(DateTime date) {
  DateTime lastDateOfMonth =
      DateTime(date.year, date.month, 1).subtract(const Duration(days: 1));
  return lastDateOfMonth.day;
}
