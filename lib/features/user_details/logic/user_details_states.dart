import 'package:perfection_task/features/user_list/data/user_model.dart';

abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final User user;

  UserDetailsLoaded(this.user);
}

class UserDetailsError extends UserDetailsState {
  final String message;

  UserDetailsError(this.message);
}