import '../../../../domain/entity/workspace.dart';

class Category {
  final String name;
  final String description;
  final List<Workspace> workspaces;

  Category({
    required this.name,
    required this.description,
    required List<Workspace>? workspaces,
  }) : workspaces = workspaces ?? [];

  String getImage() {
    try {
      return workspaces.first.imageUrls[0];
    } catch (e) {
      return '';
    }
  }
}
