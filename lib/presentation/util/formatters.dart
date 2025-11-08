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

