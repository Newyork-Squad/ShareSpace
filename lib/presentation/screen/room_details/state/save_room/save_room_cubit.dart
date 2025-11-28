import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/domain/usecase/workspace/remove_saved_workspace.dart';

import '../../../../../domain/usecase/workspace/save_workspace.dart';
import 'save_room_state.dart';

class SaveRoomCubit extends Cubit<SaveRoomState> {
  final SaveWorkspaceUseCase _saveWorkspaceUseCase;
  final RemoveSavedWorkspaceUseCase _removeSavedWorkspaceUseCase;

  SaveRoomCubit({
    required SaveWorkspaceUseCase saveWorkspaceUseCase,
    required RemoveSavedWorkspaceUseCase removeSavedWorkspaceUseCase,
    bool initiallySaved = false,
  }) : _saveWorkspaceUseCase = saveWorkspaceUseCase,
       _removeSavedWorkspaceUseCase = removeSavedWorkspaceUseCase,
       super(SaveRoomState.initial(isSaved: initiallySaved));

  Future<void> toggleSave(String workspaceId) async {
    final current = state;

    emit(current.copyWith(isLoading: true, error: null));

    try {
      if (!current.isSaved) {
        await _saveWorkspaceUseCase(workspaceId);
        emit(current.copyWith(isSaved: true, isLoading: false));
      } else {
        await _removeSavedWorkspaceUseCase(workspaceId);
        emit(current.copyWith(isSaved: false, isLoading: false));
      }
    } catch (e) {
      final message = e.toString().replaceFirst('Exception: ', '');
      emit(
        current.copyWith(
          isLoading: false,
          error: message.isEmpty ? 'Something went wrong.' : message,
        ),
      );
    }
  }
}
