class AppNotificationModel {
  final String id;
  final String tripId;
  final String toUserId;
  final String toUserType; // user | driver
  final bool isRead;
  final DateTime createdAt;

  AppNotificationModel({
    required this.id,
    required this.tripId,
    required this.toUserId,
    required this.toUserType,
    required this.isRead,
    required this.createdAt,
  });

  factory AppNotificationModel.fromJson(Map<String, dynamic> json, String id) {
    return AppNotificationModel(
      id: id,
      tripId: json['tripId'],
      toUserId: json['toUserId'],
      toUserType: json['toUserType'],
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt']?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tripId': tripId,
      'toUserId': toUserId,
      'toUserType': toUserType,
      'isRead': isRead,
      'createdAt': createdAt,
    };
  }
}
