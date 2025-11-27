import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/domain/usecase/workspace/get_best_price.dart';
import 'package:share_space/domain/usecase/workspace/get_featured.dart';
import 'package:share_space/domain/usecase/workspace/get_popular.dart';
import 'package:share_space/domain/usecase/workspace/get_top_rated.dart';
import 'package:share_space/presentation/screen/%20section/state/section_state.dart';
import 'package:share_space/presentation/screen/%20section/state/section_type_model.dart';

import '../../../../domain/usecase/workspace/get_best.dart';

class SectionCubit extends Cubit<SectionState> {
  final GetBestUseCase _getBestUseCase;
  final GetBestPriceUseCase _getBestPriceUseCase;
  final GetFeaturedUseCase _getFeaturedUseCase;
  final GetPopularUseCase _getPopularUseCase;
  final GetTopRatedUseCase _getTopRatedUseCase;

  SectionCubit(
      this._getBestUseCase,
      this._getBestPriceUseCase,
      this._getFeaturedUseCase,
      this._getPopularUseCase,
      this._getTopRatedUseCase,
      ) : super(SectionInitial());

  Future<void> loadWorkspaces(SectionType type) async {
    emit(SectionLoading());
    try {
      final workspaces = switch (type) {
        SectionType.best => await _getBestUseCase(),
        SectionType.bestPrice => await _getBestPriceUseCase(),
        SectionType.featured => await _getFeaturedUseCase(),
        SectionType.popular => await _getPopularUseCase(),
        SectionType.topRated => await _getTopRatedUseCase(),
      };
      emit(SectionLoaded(workspaces));
    } catch (e) {
      emit(SectionError(e.toString()));
    }
  }
}