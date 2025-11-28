import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';

import '../../../../domain/entity/search.dart';
import '../../../../domain/usecase/search/search_workspaces.dart';
import '../../../../domain/usecase/workspace/get_best.dart';
import '../../shared/ui_state/mapper/workspace_ui_mapper.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetBestUseCase _getBestUseCase;
  final SearchWorkspacesUseCase _searchWorkspacesUseCase;

  SearchCubit(this._getBestUseCase, this._searchWorkspacesUseCase)
    : super(SearchInitial());

  Future<void> fetchSearch(
    String? keyword,
    double? minPrice,
    double? maxPrice,
    double? rating,
    List<String>? services,
    double? latitude,
    double? longitude,
    String? location,
  ) async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      try {
        emit(SearchLoading());
        final searchResults = await _searchWorkspacesUseCase.execute(
          SearchRequest(
            keyword: keyword,
            minPrice: minPrice,
            maxPrice: maxPrice,
            rating: rating,
            services: services,
            latitude: latitude,
            longitude: longitude,
            location: location,
          ),
        );
        emit(
          SearchLoaded(
            currentState.query,
            currentState.isSearching,
            currentState.selectedRate,
            currentState.priceStart,
            currentState.priceEnd,
            currentState.services,
            currentState.lastViewed,
            searchResults.map((e) => mapWorkToUiState(e)).toList(),
          ),
        );
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    }
  }

  Future<void> fetchLastViewed() async {
    final currentState = state;
    emit(SearchLoading());
    try {
      final lastViewed = await _getBestUseCase();
      double priceEnd = 300;
      if (lastViewed.isNotEmpty) {
        priceEnd = lastViewed
            .map((e) => (e.pricePerHour).toDouble())
            .reduce((a, b) => a > b ? a : b);
      }
      emit(
        SearchLoaded(
          '',
          false,
          0,
          0,
          priceEnd.toInt(),
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
