extension AddDotToString on String {
  //convert 1000000 => 1.000.000
  String toMoney() {
    String value = this;
    int count = 0;
    for (var index = value.length - 1; index >= 0; index--) {
      count++;
      if (count == 3) {
        if (index > 0) {
          if (value[index - 1] == ".") {
            index--;
          } else {
            value =
                "${value.substring(0, index)}.${value.substring(index, value.length)}";
          }
        }
        count = 0;
      }
    }
    return value;
  }
}

extension Date on DateTime {
  String getDate() {
    var dateTimeStr = toString();
    dateTimeStr = dateTimeStr.substring(0, dateTimeStr.indexOf(" "));
    return dateTimeStr;
  }
}
