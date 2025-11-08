import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/domain/usecase/workspace/get_best.dart';
import 'package:share_space/domain/usecase/workspace/get_best_price.dart';
import 'package:share_space/domain/usecase/workspace/get_near_to_you.dart';
import 'package:share_space/domain/usecase/workspace/get_popular.dart';
import 'package:share_space/domain/usecase/workspace/get_top_rated.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBestUseCase _getBestUseCase;
  final GetBestPriceUseCase _getBestPriceUseCase;
  final GetPopularUseCase _getPopularUseCase;
  final GetNearToYouUseCase _getNearToYouUseCase;
  final GetTopRatedUseCase _getTopRatedUseCase;

  HomeCubit(
    this._getBestUseCase,
    this._getBestPriceUseCase,
    this._getPopularUseCase,
    this._getNearToYouUseCase,
    this._getTopRatedUseCase,
  ) : super(HomeInitial());

  Future<void> fetchHome() async {
    emit(HomeLoading());
    try {
      final (
        best,
        popular,
        bestPrice,
        topRated,
        nearToYou,
      ) = await (
        _getBestUseCase(),
        _getPopularUseCase(),
        _getBestPriceUseCase(),
        _getTopRatedUseCase(),
        _getNearToYouUseCase(latitude: 0.0, longitude: 0.0),
      ).wait;

      emit(HomeLoaded(
        best,
        bestPrice,
        popular,
        nearToYou,
        topRated
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
