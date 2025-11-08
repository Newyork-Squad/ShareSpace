import 'package:share_space/domain/entity/workspace.dart';
import 'category.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Workspace> best;
  final List<Workspace> bestPrice;
  final List<Workspace> popular;
  final List<Workspace> nearToYou;
  final List<Workspace> topRated;
  late List<Category> categories = [
    Category(name: "All", description: "All workspaces", workspaces: []),
    Category(name: "Best", description: "A room with quality that reflects your achievement", workspaces: best),
    Category(name: "Best Price", description: "Best prices for your needs", workspaces: bestPrice),
    Category(name: "Popular", description: "Many people use it", workspaces: popular),
    Category(name: "Near To You", description: "Just by your location", workspaces: nearToYou),
    Category(name: "Top Rated", description: "Everyone likes it", workspaces: topRated),
  ];
  int selectedIndex = 0;

  HomeLoaded(
    this.best,
    this.bestPrice,
    this.popular,
    this.nearToYou,
    this.topRated,
  );
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
