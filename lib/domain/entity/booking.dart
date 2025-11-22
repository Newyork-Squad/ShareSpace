import 'package:share_space/domain/entity/workspace.dart';

class Booking {
  final String id;
  final Workspace workspace;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final double duration;
  final String paymentType;
  final double cost;
  final String status;
  final String paymentStatus;


  Booking({
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
  });
}

enum BookingStatus { upcoming, completed, canceled }
