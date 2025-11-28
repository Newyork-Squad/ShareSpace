import 'package:share_space/domain/entity/workspace.dart';

abstract class SavedWorkspacesState {}

class SavedWorkspacesInitial extends SavedWorkspacesState {}

class SavedWorkspacesLoading extends SavedWorkspacesState {}

class SavedWorkspacesLoaded extends SavedWorkspacesState {
  final List<Workspace> workspaces;

  SavedWorkspacesLoaded(this.workspaces);
}

class SavedWorkspacesEmpty extends SavedWorkspacesState {}

class SavedWorkspacesError extends SavedWorkspacesState {
  final String message;

  SavedWorkspacesError(this.message);
}
