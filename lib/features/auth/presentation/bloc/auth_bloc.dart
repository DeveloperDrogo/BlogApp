import 'dart:async';

import 'package:clean/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/core/common/entities/user.dart';
import 'package:clean/features/auth/domain/usecase/current_user.dart';
import 'package:clean/features/auth/domain/usecase/user_login.dart';
import 'package:clean/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp; //this must as private
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required AppUserCubit appUserCubit,
      required CurrentUser currentUser})
      : _userSignUp =
            userSignUp, //initializer list becouse private variable should not accessible for outside
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignup>(_authSignup);
    on<AuthLogin>(_authLogin);
    on<AuthIsUserLoggedIn>(_authIsUserLoggedIn);
  }

  FutureOr<void> _authSignup(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoader());
    // _userSignUp.call(UserSignupParms( //we can use like this also or below i give one more methoe
    //   email: event.email,
    //   name: event.name,
    //   password: event.password,
    // ));
    final res = await _userSignUp(
      UserSignupParms(
        //this is benfit of using call method
        email: event.email,
        name: event.name,
        password: event.password,
      ),
    );

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  FutureOr<void> _authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoader());

    final res = await _userLogin(
      UserLoginParms(
        event.email,
        event.password,
      ),
    );

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  FutureOr<void> _authIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoader());
    final res = await _currentUser(NoParms());

    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(
      AuthSuccess(user: user),
    );
  }
}
