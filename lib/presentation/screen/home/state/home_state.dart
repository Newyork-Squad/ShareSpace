import 'package:share_space/domain/entity/workspace.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Workspace> best;
  final List<Workspace> bestPrice;
  final List<Workspace> popular;
  final List<Workspace> nearToYou;
  final List<Workspace> topRated;

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
