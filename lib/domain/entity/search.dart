class SearchRequest {
  final String? keyword;
  final double? minPrice;
  final double? maxPrice;
  final double? rating;
  final List<String>? services;
  final double? latitude;
  final double? longitude;
  final String? location;

  SearchRequest({
    this.keyword,
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.services,
    this.latitude,
    this.longitude,
    this.location
  });
}
