import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecase/workspace/get_saved_workspace.dart';
import 'saved_workspaces_state.dart';

class SavedWorkspacesCubit extends Cubit<SavedWorkspacesState> {
  final GetSavedWorkspacesUseCase _getSavedWorkspacesUseCase;

  SavedWorkspacesCubit(this._getSavedWorkspacesUseCase)
      : super(SavedWorkspacesInitial());

  Future<void> fetchSavedWorkspaces() async {
    emit(SavedWorkspacesLoading());
    try {
      final result = await _getSavedWorkspacesUseCase();

      if (result.isEmpty) {
        emit(SavedWorkspacesEmpty());
      } else {
        emit(SavedWorkspacesLoaded(result));
      }
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(SavedWorkspacesError(
        message.isEmpty ? 'Failed to load saved workspaces.' : message,
      ));
    }
  }
}
