import 'package:cloud_firestore/cloud_firestore.dart';

class TripModel {
  final String id;

  final String userId;
  final String? driverId;
  final String? username;
  final String? drivername;
  final String governorate;
  final String status;
  final String tripId;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? imageUrl;
  GeoPoint? userlocation;
  GeoPoint? driverlocation;
  final String? goto;

  TripModel({
    required this.id,
    required this.goto,
    required this.userId,
    required this.imageUrl,
    this.tripId = '',
    this.drivername,
    this.username,
    this.driverId,
    required this.governorate,
    required this.status,
    required this.userlocation,
     this.driverlocation,
    required this.createdAt,
    this.completedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json, String id) {
    return TripModel(
      id: id,
        goto: json['goto'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
      tripId: json['tripId'] ?? '',
      driverId: json['driverId'],
      drivername: json['drivername'],
      username: json['username'],
      governorate: json['governorate'],
      status: json['status'],
      userlocation: json['userlocation'],
      driverlocation: json['driverlocation'],
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
      completedAt: json['completedAt']?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'goto': goto,
      'driverId': driverId,
      'imageUrl': imageUrl,
      'username':username,
      'tripId': tripId,
      'drivername':drivername,
      'governorate': governorate,
      'status': status,
      'createdAt': createdAt,
      'completedAt': completedAt,
      'userlocation': userlocation,
      'driverlocation': driverlocation,
    };
  }
}
