import 'package:share_space/domain/entity/workspace.dart';
import 'package:share_space/domain/repository/workspace_repository.dart';

class WorkspaceRepositoryImpl implements WorkspaceRepository {
  final _workspaces = <Workspace>[
    Workspace(
      id: 1,
      name: 'Creative Hub',
      locationName: 'Downtown Core',
      longitude: -74.0060,
      latitude: 40.7128,
      rate: 4.8,
      pricePerHour: 25.0,
      services: [Services.wifi, Services.ac, Services.powerBackup],
      imageUrls: ['https://example.com/image1.jpg'],
      description: 'A vibrant coworking space in the heart of the city.',
      rules: 'No smoking, no pets.',
      ownerId: 101,
    ),
    Workspace(
      id: 2,
      name: 'The Workatory',
      locationName: 'Brooklyn',
      longitude: -73.9900,
      latitude: 40.7228,
      rate: 4.5,
      pricePerHour: 15.0,
      services: [Services.wifi, Services.whiteboard],
      imageUrls: ['https://example.com/image2.jpg'],
      description: 'An affordable and friendly workspace.',
      rules: 'Respect quiet zones.',
      ownerId: 102,
    ),
    Workspace(
      id: 3,
      name: 'Innovate Space',
      locationName: 'Midtown Manhattan',
      longitude: -73.9857,
      latitude: 40.7549,
      rate: 4.9,
      pricePerHour: 35.0,
      services: [Services.wifi, Services.ac, Services.whiteboard, Services.powerBackup],
      imageUrls: ['https://example.com/image3.jpg'],
      description: 'A premium workspace with state-of-the-art facilities.',
      rules: 'Booking required for meeting rooms.',
      ownerId: 103,
    ),
  ];

  @override
  Future<List<Workspace>> getBest() async {
    await Future.delayed(const Duration(seconds: 1));
    return _workspaces;
  }

  @override
  Future<List<Workspace>> getBestPrice() async {
    await Future.delayed(const Duration(seconds: 1));
    return _workspaces;
  }

  @override
  Future<List<Workspace>> getNearToYou({
    required double latitude,
    required double longitude,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return _workspaces;
  }

  @override
  Future<List<Workspace>> getPopular() async {
    await Future.delayed(const Duration(seconds: 1));
    return _workspaces;
  }

  @override
  Future<List<Workspace>> getTopRated() async {
    await Future.delayed(const Duration(seconds: 1));
    return _workspaces;
  }
}
