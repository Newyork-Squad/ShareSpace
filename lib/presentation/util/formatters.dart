String formatHourlyPrice(double price, {String currency = 'IQD'}) {
  final normalized = price.isNaN ? 0 : price;
  final isWhole = normalized == normalized.roundToDouble();
  final formattedValue =
      isWhole ? normalized.toStringAsFixed(0) : normalized.toStringAsFixed(2);
  return '$formattedValue $currency/h';
}

String formatRating(double? rating) {
  if (rating == null) {
    return '-';
  }
  return rating.toStringAsFixed(1);
}

String formatDate(DateTime dt){
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final day = dt.day.toString().padLeft(2, '0');
  final month = months[dt.month - 1];
  final year = dt.year;
  return '$day $month $year';
}

String formatTime(DateTime dt){
  final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
  final hour = hour12.toString().padLeft(2, '0');
  final minute = dt.minute.toString().padLeft(2, '0');
  final period = dt.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $period';
}