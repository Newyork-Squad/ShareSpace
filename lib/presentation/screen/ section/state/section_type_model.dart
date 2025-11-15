enum SectionType { best, bestPrice, featured, popular, topRated }

extension SectionTypeExtension on SectionType {
  String get title {
    return switch (this) {
      SectionType.best => 'Near to you',
      SectionType.bestPrice => 'Best Price',
      SectionType.featured => 'Featured',
      SectionType.popular => 'Popular',
      SectionType.topRated => 'Top Rated',
    };
  }
}
