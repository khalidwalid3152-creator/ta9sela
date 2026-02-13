import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ta9sela/feature/home/data/cubits/tripCubit/tripState.dart';
import 'package:ta9sela/feature/home/data/models/TripModel.dart';
import 'package:ta9sela/feature/home/data/repositories/TripRepository.dart';



class TripCubit extends Cubit<TripState> {
  final TripRepository repository;

  TripCubit(this.repository) : super(TripInitial());

  /// Create trip (User)
  Future<void> createTrip(TripModel trip) async {
    emit(TripLoading());
    try {
      final tripId = await repository.createTrip(trip);
      emit(TripCreated(tripId));
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }

  /// Get single trip
  Future<void> getTrip(String tripId) async {
    emit(TripLoading());
    try {
      final trip = await repository.getTrip(tripId);
      if (trip == null) {
        emit(TripError('Trip not found'));
      } else {
        emit(TripLoaded(trip));
      }
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }
 

  Future<void> updateTripStatus(String tripId, String status , GeoPoint location) async {
   
    try {
      await repository.updateTripStatus(tripId, status,location);
     

      emit(TripUpdated());
    } catch (e) {
      emit(TripError(e.toString()));
    }
  }
  Future<void> deleteTrip(String tripId) async {
  try {
    await FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .delete();

   
  } catch (e) {
    emit(TripError(e.toString()));
  }
}



  /// User trips history
  void getUserTrips(String userId) {
   
    repository.getTripsByUser(userId).listen(
      (trips) {
        emit(TripsLoaded(trips));
      },
      onError: (e) {
        emit(TripError(e.toString()));
      },
    );
  }

  /// Driver trips
  void getDriverTrips(String driverId) {
    emit(TripLoading());
    repository.getTripsByDriver(driverId).listen(
      (trips) {
        emit(TripsLoaded(trips));
      },
      onError: (e) {
        emit(TripError(e.toString()));
      },
    );
  }

  /// Live tracking
  void streamTrip(String tripId) {
    emit(TripLoading());
    repository.streamTrip(tripId).listen(
      (trip) {
        emit(TripLoaded(trip));
      },
      onError: (e) {
        emit(TripError(e.toString()));
      },
    );
  }
}
