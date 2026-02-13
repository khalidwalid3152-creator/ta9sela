import 'package:ta9sela/feature/home/data/models/userModel.dart';

abstract class UserState {}

class UserLoading extends UserState {}

class UserDone extends UserState {
  final UserModel? user;
  UserDone({this.user,});
}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
