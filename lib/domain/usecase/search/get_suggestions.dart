import '../../repository/search_repository.dart';

class GetSuggestionsUseCase {
  final SearchRepository _repository;

  GetSuggestionsUseCase(this._repository);

  Future<List<String>> execute(String keyword) async {
    return await _repository.getSuggestions(keyword: keyword);
  }
}
