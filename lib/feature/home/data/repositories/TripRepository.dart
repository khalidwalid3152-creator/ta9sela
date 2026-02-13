import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ta9sela/feature/home/data/models/TripModel.dart';


class TripRepository {
  final _trips = FirebaseFirestore.instance.collection('trips');

  /// Create trip
  Future<String> createTrip(TripModel trip) async {
    final doc = await _trips.add(trip.toJson());
    return doc.id;
  }

  /// Get trip
  Future<TripModel?> getTrip(String tripId) async {
    final doc = await _trips.doc(tripId).get();
    if (!doc.exists) return null;
    return TripModel.fromJson(doc.data()!, doc.id);
  }

  /// Update status
  Future<void> updateTripStatus(String tripId, String status,GeoPoint location,) async {
    await _trips.doc(tripId).update({'status': status});
    await _trips.doc(tripId).update({'driverlocation': location});
  }

  /// Assign driver
  Future<void> assignDriver(String tripId, String driverId) async {
    await _trips.doc(tripId).update({
      'driverId': driverId,
      'status': 'accepted'
    });
  }

  /// Live stream (Tracking)
  Stream<TripModel> streamTrip(String tripId) {
    return _trips.doc(tripId).snapshots().map(
        (doc) => TripModel.fromJson(doc.data()!, doc.id));
  }

  /// Trips history
  Stream<List<TripModel>> getTripsByUser(String userId) {
    return _trips
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((e) => e.docs
            .map((d) => TripModel.fromJson(d.data(), d.id))
            .toList());
  }

  Stream<List<TripModel>> getTripsByDriver(String driverId) {
    return _trips
        .where('driverId', isEqualTo: driverId)
        .snapshots()
        .map((e) => e.docs
            .map((d) => TripModel.fromJson(d.data(), d.id))
            .toList());
  }
}
