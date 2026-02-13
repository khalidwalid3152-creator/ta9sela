import 'package:ta9sela/feature/home/data/models/TripModel.dart';

abstract class TripState {}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripCreated extends TripState {
  final String tripId;
  TripCreated(this.tripId);
}

class TripLoaded extends TripState {
  final TripModel trip;
  TripLoaded(this.trip);
}

class TripsLoaded extends TripState {
  final List<TripModel> trips;
  TripsLoaded(this.trips);
}

class TripUpdated extends TripState { }


class TripError extends TripState {
  final String message;
  TripError(this.message);
}
