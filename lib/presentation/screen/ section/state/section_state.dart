import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entity/workspace.dart';

abstract class SectionState {}

class SectionInitial extends SectionState {}

class SectionLoading extends SectionState {}

class SectionLoaded extends SectionState {
  final List<Workspace> workspaces;
  SectionLoaded(this.workspaces);
}

class SectionError extends SectionState {
  final String message;
  SectionError(this.message);
}
