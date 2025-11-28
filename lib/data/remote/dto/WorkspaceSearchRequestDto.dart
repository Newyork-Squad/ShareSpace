class WorkspaceSearchRequestDto {
  final String? keyword;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;
  final double? latitude;
  final double? longitude;
  final String? location;
  final List<String>? services;

  WorkspaceSearchRequestDto({
    this.keyword,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.latitude,
    this.longitude,
    this.location,
    this.services,
  });

  Map<String, dynamic> toJson() {
    return {
      "keyword": keyword,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "minRating": minRating,
      "latitude": latitude,
      "longitude": longitude,
      "location": location,
      "services": services,
    };
  }
}
