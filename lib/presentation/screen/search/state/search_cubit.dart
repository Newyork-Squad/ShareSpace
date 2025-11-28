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
    String keyword,
  ) async {
    final currentState = state;
    if (currentState is SearchLoaded) {
      try {
        emit(SearchLoading());
        final searchResults = await _searchWorkspacesUseCase.execute(
          SearchRequest(
            keyword: keyword,
            minPrice: currentState.priceStart.toDouble(),
            maxPrice: currentState.priceEnd.toDouble(),
            rating: currentState.selectedRate.toDouble(),
            services: currentState.selectedServicesIndices.map((e) => ServicesUiState.values[e].toString()).toList(),
            // latitude: latitude,
            // longitude: longitude,
            // location: location,
          ),
        );
        emit(
          SearchLoaded(
            currentState.query,
            currentState.isSearching,
            currentState.selectedRate,
            currentState.priceStart,
            currentState.priceEnd,
            currentState.priceStart,
            currentState.priceEnd,
            currentState.selectedRateIndices,
            currentState.selectedServicesIndices,
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
      double priceStart = 20;
      double priceEnd = 30;
      if (lastViewed.isNotEmpty) {
        final prices = lastViewed
            .map((e) => (e.pricePerHour).toDouble())
            .toList();
        priceStart = prices.reduce((a, b) => a < b ? a : b);
        priceEnd = prices.reduce((a, b) => a > b ? a : b);
      }

      emit(
        SearchLoaded(
          '',
          false,
          0,
          (priceStart * 0.5).toInt(),
          (priceEnd * 1.5).toInt(),
          priceStart.toInt(),
          priceEnd.toInt(),
          [],
          [],
          [],
          lastViewed.map((e) => mapWorkToUiState(e)).toList(),
          [],
        ),
      );
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void updateQuery(String query) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          query,
          currentState.isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          currentState.priceEnd,
          currentState.selectedRateIndices,
          currentState.selectedServicesIndices,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
    fetchSearch(query);
  }

  void updateIsSearching(bool isSearching) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          currentState.priceEnd,
          currentState.selectedRateIndices,
          currentState.selectedServicesIndices,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }

  void updateSelectedRate(double selectedRate) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          currentState.isSearching,
          selectedRate.toInt(),
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          currentState.priceEnd,
          currentState.selectedRateIndices,
          currentState.selectedServicesIndices,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }

  void updatePriceStart(int priceStart) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          currentState.isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          priceStart,
          currentState.priceEnd,
          currentState.selectedRateIndices,
          currentState.selectedServicesIndices,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }

  void updatePriceEnd(int priceEnd) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          currentState.isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          priceEnd,
          currentState.selectedRateIndices,
          currentState.selectedServicesIndices,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }

  void updateServices(List<ServicesUiState> services) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          currentState.isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          currentState.priceEnd,
          currentState.selectedRateIndices,
          currentState.selectedServicesIndices,
          services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }

  void updateSelectedServices(List<int> services) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          currentState.isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          currentState.priceEnd,
          currentState.selectedRateIndices,
          services,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }

  void updateSelectedRates(List<int> rates) {
    final currentState = state;
    if (currentState is SearchLoaded) {
      emit(
        SearchLoaded(
          currentState.query,
          currentState.isSearching,
          currentState.selectedRate,
          currentState.priceStartRange,
          currentState.priceEndRange,
          currentState.priceStart,
          currentState.priceEnd,
          rates,
          currentState.selectedServicesIndices,
          currentState.services,
          currentState.lastViewed,
          currentState.searchResults,
        ),
      );
    }
  }
}
