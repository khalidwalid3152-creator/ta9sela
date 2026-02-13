import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ta9sela/feature/home/data/models/driverModel.dart';

class DriverRepository {
  final _drivers = FirebaseFirestore.instance.collection('drivers');

  Future<void> createDriver(DriverModel driver) async {
    await _drivers.doc(driver.id).set(driver.toJson());
  }

  Future<DriverModel?> getDriver(String driverId) async {
    final doc = await _drivers.doc(driverId).get();
    if (!doc.exists) return null;
    return DriverModel.fromJson(doc.data()!, doc.id);
  }

  /// Drivers حسب المحافظة
  Stream<List<DriverModel>> getDriversByGovernorate(String governorate) {
    return _drivers
        .where('governorate', isEqualTo: governorate)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((e) => DriverModel.fromJson(e.data(), e.id))
              .toList(),
        );
  }

  /// تحديث الموقع لايف
  Future<void> updateDriverLocation(
    String driverId,
    double lat,
    double lng,
  ) async {
    await _drivers.doc(driverId).update({
      'currentLocation': {'lat': lat, 'lng': lng},
    });
  }

  //الصوره
  Future<String> uploadImageFromVariable(File imageFile, String userId) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('users')
        .child('$userId.jpg');

    await ref.putFile(imageFile);

    return await ref.getDownloadURL();
  }

  Future<void> updateDriver(DriverModel driver) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(driver.id)
        .update(driver.toJson());
  }
}
