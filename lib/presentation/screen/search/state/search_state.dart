import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final String query;
  final bool isSearching;
  final int selectedRate;
  final int priceStartRange;
  final int priceEndRange;
  final int priceStart;
  final int priceEnd;
  final List<int> selectedRateIndices;
  final List<int> selectedServicesIndices;
  final List<ServicesUiState> services;
  final List<WorkspaceUiState> lastViewed;
  final List<WorkspaceUiState> searchResults;

  SearchLoaded(
    this.query,
    this.isSearching,
    this.selectedRate,
    this.priceStartRange,
    this.priceEndRange,
    this.priceStart,
    this.priceEnd,
    this.selectedRateIndices,
    this.selectedServicesIndices,
    this.services,
    this.lastViewed,
    this.searchResults,
  );
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
