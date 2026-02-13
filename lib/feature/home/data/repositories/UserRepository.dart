import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta9sela/feature/home/data/models/userModel.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.id)
        .set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc =
        await _firestore.collection('users').doc(userId).get();

    if (!doc.exists) return null;

    return UserModel.fromJson(
      doc.data()!,
      doc.id,
    );
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.id)
        .update(user.toJson());
  }

  //لجلب محافظه المستخدم
  Future<String> getUserGovernorate(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();

    if (!doc.exists) {
      throw Exception('User not found');
    }

    return doc['governorate'] as String;
  }
}
