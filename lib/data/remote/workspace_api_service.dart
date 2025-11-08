import 'dto/WorkspaceResponse.dart';

abstract class WorkspaceApiService {
  Future<List<WorkspaceResponse>> getAll({
    int page = 0,
    int size = 10,
    String sortBy = 'createdAt',
    String direction = 'desc',
  });

  Future<List<WorkspaceResponse>> getByCategory(
    String category, {
    int page = 0,
    int size = 10,
  });

  Future<List<WorkspaceResponse>> getNearToYou({
    required double latitude,
    required double longitude,
    int page = 0,
    int size = 10,
  });

  Future<List<WorkspaceResponse>> getFeatured({int page = 0, int size = 10});

  Future<WorkspaceResponse> getById(String id);
}
