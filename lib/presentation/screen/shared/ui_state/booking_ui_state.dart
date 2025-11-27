

import 'package:share_space/presentation/screen/shared/ui_state/workspace_ui_state.dart';
import 'package:share_space/presentation/util/image_const.dart';

class BookingUiState {
  final String bookingId;
  final String date;
  final String startTime;
  final String endTime;
  final BookingStatusUiState status;
  final WorkspaceUiState workspace;

  BookingUiState({
    required this.bookingId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.workspace,
  }) ;

  String getImage() {
    try {
      return workspace.imageUrls[0];
    } catch (e) {
      return FALLBACK_IMAGE;
    }
  }
}

enum BookingStatusUiState { upcoming, completed, canceled }