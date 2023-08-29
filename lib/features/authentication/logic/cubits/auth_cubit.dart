import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/core/utils/constants.dart';
import 'package:shop_app/features/authentication/data/models/auth.dart';
import 'package:shop_app/features/authentication/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Auth? auth;
  Timer? timer;
  final _authRepo = AuthRepo();

  void tryAutoLogin() {
    final savedAuth = _authRepo.tryAutoLogin();
    if (savedAuth != null) {
      if (savedAuth.expiryDate.isBefore(DateTime.now())) return;
      auth = savedAuth;
      userToken = auth!.token;
      emit(AuthUserAuthenticatingChanged(status: AuthStatus.authenticated));
    }
  }

  void createUser({required String email, required String password}) async {
    emit(AuthUserAuthLoading());
    try {
      auth = await _authRepo.createUser(email: email, password: password);
      print(auth);
      print(auth!.expiryDate);
      print(auth!.usedId);
      userToken = auth!.token;
      autoLogout();

      emit(AuthUserAuthenticatingChanged(status: AuthStatus.authenticated));
    } on DioException catch (dioError) {
      emit(AuthUserAuthFailed(dioError.message ?? 'Something Went wrong'));
    } catch (error) {
      emit(AuthUserAuthFailed(error.toString()));
      rethrow;
    }
  }

  void login({required String email, required String password}) async {
    emit(AuthUserAuthLoading());
    try {
      auth = await _authRepo.loginUser(email: email, password: password);
      print(auth);
      print(auth!.expiryDate);
      print(auth!.usedId);
      userToken = auth!.token;
      autoLogout();
      emit(AuthUserAuthenticatingChanged(status: AuthStatus.authenticated));
    } on DioException catch (dioError) {
      emit(AuthUserAuthFailed(dioError.message ?? 'Something Went wrong'));
    } catch (error) {
      emit(AuthUserAuthFailed(error.toString()));
      rethrow;
    }
  }

  void autoLogout() {
    if (timer != null) {
      timer!.cancel();
    }
    final timeToExpire = auth!.expiryDate.difference(DateTime.now()).inSeconds;
    timer = Timer(Duration(seconds: timeToExpire), logout);
  }

  void logout() {
    auth = null;
    userToken = '';
    emit(AuthUserAuthenticatingChanged(status: AuthStatus.unauthenticated));
    _authRepo.removeAuthData();
  }
}
