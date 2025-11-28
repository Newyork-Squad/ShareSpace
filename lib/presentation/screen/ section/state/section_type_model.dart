enum SectionType { best, bestPrice, featured, popular, topRated }

extension SectionTypeExtension on SectionType {
  String get title {
    return switch (this) {
      SectionType.best => 'Best',
      SectionType.bestPrice => 'Best Price',
      SectionType.featured => 'Featured',
      SectionType.popular => 'Popular',
      SectionType.topRated => 'Top Rated',
    };
  }
}

extension StringToSectionType on String {
  SectionType? toSectionType() {
    return switch (toLowerCase()) {
      'best' => SectionType.best,
      'best price' => SectionType.bestPrice,
      'featured' => SectionType.featured,
      'popular' => SectionType.popular,
      'top rated' => SectionType.topRated,
      _ => null,
    };
  }
}