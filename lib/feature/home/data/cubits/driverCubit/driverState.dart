import 'package:ta9sela/feature/home/data/models/driverModel.dart';

abstract class DriverState {}

class DriverLoading extends DriverState {}

class DriverDone extends DriverState {
  final DriverModel? driver;
  final List<DriverModel>? drivers;

  DriverDone({this.driver, this.drivers});
}


class DriverError extends DriverState {}
