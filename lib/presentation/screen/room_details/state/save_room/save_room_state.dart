class SaveRoomState {
  final bool isSaved;
  final bool isLoading;
  final String? error;

  const SaveRoomState({
    required this.isSaved,
    this.isLoading = false,
    this.error,
  });

  factory SaveRoomState.initial({bool isSaved = false}) {
    return SaveRoomState(isSaved: isSaved);
  }

  SaveRoomState copyWith({
    bool? isSaved,
    bool? isLoading,
    String? error,
  }) {
    return SaveRoomState(
      isSaved: isSaved ?? this.isSaved,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}