import '../entity/workspace.dart';

abstract class WorkspaceRepository {
  Future<List<Workspace>> getBest();
  Future<List<Workspace>> getPopular();
  Future<List<Workspace>> getBestPrice();
  Future<List<Workspace>> getTopRated();
  Future<List<Workspace>> getNearToYou({
    required double latitude,
    required double longitude,
  });
  Future<List<Workspace>> getFeatured();
}