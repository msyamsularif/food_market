part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserLoadingFailed extends UserState {
  final String message;

  UserLoadingFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
