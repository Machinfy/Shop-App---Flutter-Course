part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthUserAuthLoading extends AuthState {}

class AuthUserAuthenticatingChanged extends AuthState {
  final AuthStatus status;

  AuthUserAuthenticatingChanged({required this.status});
}

class AuthUserAuthFailed extends AuthState {
  final String failureMsg;

  AuthUserAuthFailed(this.failureMsg);
}
