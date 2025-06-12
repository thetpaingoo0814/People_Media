class DTime {
  static String getDifferent(DateTime checkTime) {
    DateTime now = DateTime.now();

    final different = now.difference(checkTime).inDays;
    if (different < 1) {
      final diffHour = now.difference(checkTime).inHours;
      if (diffHour < 1) {
        final diffMinutes = now.difference(checkTime).inMinutes;
        return "$diffMinutes minutes Ago";
      } else {
        return "$diffHour hours Ago";
      }
    } else {
      return "$different days Ago";
    }
  }
}
