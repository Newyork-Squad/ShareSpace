

import 'package:share_space/presentation/screen/shared/workspace_ui_state.dart';
import 'package:share_space/presentation/util/image_const.dart';

class Booking {
  final String date;
  final String startTime;
  final String endTime;
  final bool isUpcoming;
  final bool isCancelled;
  final WorkspaceUiState workspaces;

  Booking({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.isUpcoming,
    required this.isCancelled,
    required this.workspaces,
  }) ;

  String getImage() {
    try {
      return workspaces.imageUrls[0];
    } catch (e) {
      return FALLBACK_IMAGE;
    }
  }
}
