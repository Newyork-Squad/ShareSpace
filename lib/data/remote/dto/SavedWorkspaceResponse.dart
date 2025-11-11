import 'dart:convert';
import 'WorkspaceResponse.dart';

class SavedWorkspaceResponse {
  final String id;
  final WorkspaceResponse workspace;
  final DateTime savedAt;

  SavedWorkspaceResponse({
    required this.id,
    required this.workspace,
    required this.savedAt,
  });

  factory SavedWorkspaceResponse.fromJson(Map<String, dynamic> json) {
    return SavedWorkspaceResponse(
      id: json['id'] as String,
      workspace: WorkspaceResponse.fromJson(json['workspace']),
      savedAt: DateTime.parse(json['savedAt']),
    );
  }

  static List<SavedWorkspaceResponse> listFromJson(dynamic data) {
    if (data is List) {
      return data.map((e) => SavedWorkspaceResponse.fromJson(e)).toList();
    } else if (data is String) {
      return (jsonDecode(data) as List)
          .map((e) => SavedWorkspaceResponse.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}