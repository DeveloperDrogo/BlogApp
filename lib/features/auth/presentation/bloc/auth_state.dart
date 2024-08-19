part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoader extends AuthState{}

final class AuthSuccess extends AuthState{
  final User user;
  AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState{
  final String message;
  AuthFailure({required this.message});
  
}