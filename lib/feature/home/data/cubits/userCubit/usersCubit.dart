import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta9sela/feature/home/data/cubits/userCubit/userState.dart';
import 'package:ta9sela/feature/home/data/models/userModel.dart';
import 'package:ta9sela/feature/home/data/repositories/UserRepository.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repository;

  UserCubit(this.repository) : super(UserLoading());

  /// 🔹 جلب بيانات المستخدم حسب ID
  Future<void> getUser(String userId) async {
    emit(UserLoading());
    try {
      final user = await repository.getUser(userId);
      if (user != null) {
        emit(UserDone(user:user));
      } else {
        emit(UserError("User not found"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  /// 🔹 تحديث بيانات المستخدم
  Future<void> updateUser(UserModel user) async {
    emit(UserLoading());
    try {
      await repository.updateUser(user);
      emit(UserDone(user:user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  /// 🔹 إنشاء مستخدم جديد
  Future<void> createUser(UserModel user) async {
    emit(UserLoading());
    try {
      await repository.createUser(user);
      emit(UserDone(user:user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  //داله التحقق من المستخدم

  Future<UserModel?> signInUser(String email, String password) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .where(
            'password',
            isEqualTo: password,
          ) // لازم تكون مخزنه في Firestore
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        emit(UserDone(user: UserModel.fromJson(doc.data(), doc.id)));
        
        return UserModel.fromJson(doc.data(), doc.id);
      } else {
        emit(UserError("Invalid email or password"));
        return null; // الإيميل أو الباسورد غلط
      }
    } catch (e) {
      print('Error signing in user: $e');
      return null;
    }
  }
}
