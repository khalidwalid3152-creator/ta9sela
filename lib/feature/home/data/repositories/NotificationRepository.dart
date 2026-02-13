import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta9sela/feature/home/data/models/NotificationModel.dart';


class NotificationRepository {
  final _notifications =
      FirebaseFirestore.instance.collection('notifications');

  Future<void> sendNotification(AppNotificationModel notification) async {
    await _notifications.add(notification.toJson());
  }

  Stream<List<AppNotificationModel>> getMyNotifications(String userId) {
    return _notifications
        .where('toUserId', isEqualTo: userId)
        .snapshots()
        .map((e) => e.docs
            .map((d) => AppNotificationModel.fromJson(d.data(), d.id))
            .toList());
  }
}
