import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta9sela/feature/home/data/cubits/driverCubit/driverState.dart';
import 'package:ta9sela/feature/home/data/models/driverModel.dart';
import 'package:ta9sela/feature/home/data/repositories/DriverRepository.dart';
import 'package:ta9sela/feature/home/data/repositories/UserRepository.dart';

class DriverCubit extends Cubit<DriverState> {
  final DriverRepository drepository;
  final UserRepository urepository;
  StreamSubscription? _driversSubscription;
  String? currentDriverId;

  DriverCubit(this.drepository, this.urepository) : super(DriverLoading());

  /// إنشاء سائق
  Future<void> createDriver(DriverModel driver) async {
    emit(DriverLoading());
    try {
      await drepository.createDriver(driver);
      currentDriverId = driver.id;
      // تشغيل Observer مباشرة بعد الإنشاء

      emit(DriverDone(driver: driver));
    } catch (e) {
      emit(DriverError());
    }
  }

  /// جلب سائق واحد
  Future<void> getDriver(String driverId) async {
    emit(DriverLoading());
    try {
      final driver = await drepository.getDriver(driverId);
      emit(DriverDone(driver: driver));
    } catch (e) {
      emit(DriverError());
    }
  }

  /// جلب السائقين حسب المحافظة (لايف)
  Future<void> getDriversByGovernorate (
    String governorate,
  ) async {
    emit(DriverLoading());
    _driversSubscription?.cancel();

    try {
      _driversSubscription =await drepository
          .getDriversByGovernorate(governorate)
          .listen(
            (drivers) {
              emit(DriverDone(drivers: drivers));
            },
            onError: (e) {
              emit(DriverError());
            },
          );
    } catch (e) {
      emit(DriverError());
    }
  }

  /// تحديث موقع السائق
  Future<void> updateDriverLocation(
    String driverId,
    double lat,
    double lng,
  ) async {
    try {
      await drepository.updateDriverLocation(driverId, lat, lng);
    } catch (e) {
      emit(DriverError());
    }
  }

  @override
  Future<void> close() {
    _driversSubscription?.cancel();
    return super.close();
  }

  ///داله التحقق من السائق
  Future<DriverModel?> signInDriver(String email, String password) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('drivers')
          .where('email', isEqualTo: email)
          .where(
            'password',
            isEqualTo: password,
          ) // لازم تكون مخزنه في Firestore
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        emit(DriverDone(driver: DriverModel.fromJson(doc.data(), doc.id)));
       
        return DriverModel.fromJson(doc.data(), doc.id);
      } else {
        emit(DriverError());
        return null; // الإيميل أو الباسورد غلط
      }
    } catch (e) {
      print('Error signing in driver: $e');
      return null;
    }
  }

  void getDriversByGovernorates(String governorate) {
    emit(DriverLoading());

    _driversSubscription?.cancel();

    _driversSubscription = drepository
        .getDriversByGovernorate(governorate)
        .listen(
          (drivers) {
            emit(DriverDone(drivers: drivers));
          },
          onError: (e) {
            emit(DriverError());
          },
        );
  }
   Future<void> updateDriver(DriverModel user) async {
    emit(DriverLoading());
    try {
      await drepository.updateDriver(user);
      emit(DriverDone(driver: user));
    } catch (e) {
      emit(DriverError());
    }
  }
}
