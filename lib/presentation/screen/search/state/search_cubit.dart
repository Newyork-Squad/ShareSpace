import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';

import '../../../../domain/usecase/workspace/get_best.dart';
import '../../shared/ui_state/mapper/workspace_ui_mapper.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetBestUseCase _getBestUseCase;

  SearchCubit(this._getBestUseCase) : super(SearchInitial());

  Future<void> fetchSearch() async {
  }

  Future<void> fetchLastViewed(String id) async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      try {
        final lastViewed = await _getBestUseCase();
        emit(
          SearchLoaded(
            currentState.query,
            currentState.isSearching,
            currentState.selectedRate,
            currentState.priceStart,
            currentState.priceEnd,
            currentState.services,
            lastViewed.map((e) => mapWorkToUiState(e)).toList(),
            currentState.searchResults,
          ),
        );
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    } else {
      emit(SearchLoading());
      try {
        final lastViewed = await _getBestUseCase();
        emit(
          SearchLoaded(
            '',
            false,
            0,
            0,
            760,
            [],
            lastViewed.map((e) => mapWorkToUiState(e)).toList(),
            [],
          ),
        );
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }
}
