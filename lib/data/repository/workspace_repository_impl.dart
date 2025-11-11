import 'package:share_space/domain/entity/workspace.dart';
import 'package:share_space/domain/repository/workspace_repository.dart';

import '../remote/dto/WorkspaceResponse.dart';
import '../remote/workspace_api_service.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final WorkspaceApiService _apiService;

  WorkspaceRepositoryImpl(this._apiService);

  @override
  Future<List<Workspace>> getBest() async {
    try {
      final response = await _apiService.getFeatured(page: 0, size: 10);
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch best workspaces: $e');
    }
  }

  @override
  Future<List<Workspace>> getBestPrice() async {
    try {
      final response = await _apiService.getAll(
        page: 0,
        size: 10,
        sortBy: 'price',
        direction: 'asc',
      );
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch best price workspaces: $e');
    }
  }

  @override
  Future<List<Workspace>> getNearToYou({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiService.getNearToYou(
        latitude: latitude,
        longitude: longitude,
        page: 0,
        size: 10,
      );
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch nearby workspaces: $e');
    }
  }

  @override
  Future<List<Workspace>> getPopular() async {
    try {
      final response = await _apiService.getAll(
        page: 0,
        size: 10,
        sortBy: 'reviewsNo',
        direction: 'desc',
      );
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch popular workspaces: $e');
    }
  }

  @override
  Future<List<Workspace>> getTopRated() async {
    try {
      final response = await _apiService.getAll(
        page: 0,
        size: 10,
        sortBy: 'rating',
        direction: 'desc',
      );
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch top rated workspaces: $e');
    }
  }

  Future<List<Workspace>> getByCategory(String category) async {
    try {
      final response = await _apiService.getByCategory(category);
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch workspaces by category: $e');
    }
  }

  @override
  Future<List<Workspace>> getFeatured() async {
    try {
      final response = await _apiService.getFeatured(page: 0, size: 10);
      return response.map((dto) => _mapToEntity(dto)).toList();
    } catch (e) {
      throw Exception('Failed to fetch best workspaces: $e');
    }
  }

  Future<Workspace> getById(String id) async {
    try {
      final response = await _apiService.getById(id);
      return _mapToEntity(response);
    } catch (e) {
      throw Exception('Failed to fetch workspace details: $e');
    }
  }

  // Map DTO to Domain Entity
  Workspace _mapToEntity(WorkspaceResponse dto) {
    return Workspace(
      id: int.tryParse(dto.id) ?? 0,
      name: dto.title,
      locationName: dto.location,
      longitude: dto.longitude,
      latitude: dto.latitude,
      rate: dto.rating ?? 0.0,
      pricePerHour: dto.price,
      services: _mapAmenities(dto.amenities),
      imageUrls: dto.images ?? [],
      description: dto.description,
      rules: dto.houseRules ?? '',
      ownerId: 0,
    );
  }

  // Map amenities to Services enum
  List<Services> _mapAmenities(List<String> amenities) {
    List<Services> services = [];
    for (var amenity in amenities) {
      print("Btatssdas $amenity");
      switch (amenity.toLowerCase()) {
        case 'wi_fi':
          services.add(Services.wifi);
          break;
        case 'ac':
        case 'air_conditioning':
          services.add(Services.ac);
          break;
        case 'whiteboard':
          services.add(Services.whiteboard);
          break;
        case 'coffe_machine':
          services.add(Services.coffee);
          break;
        case 'power_backup':
        case 'powerbackup':
          services.add(Services.powerBackup);
          break;
      }
    }
    return services;
  }
}
