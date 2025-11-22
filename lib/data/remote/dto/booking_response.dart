import 'WorkspaceResponse.dart';

class BookingResponse {
  final String id;
  final WorkspaceResponse workspace;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final double duration;
  final String paymentType;
  final double cost;
  final String status;
  final String paymentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingResponse({
    required this.id,
    required this.workspace,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.paymentType,
    required this.cost,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      id: json['id'],
      workspace: WorkspaceResponse.fromJson(json['workspace']),
      userId: json['userId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      duration: (json['duration'] as num).toDouble(),
      paymentType: json['paymentType'],
      cost: (json['cost'] as num).toDouble(),
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
