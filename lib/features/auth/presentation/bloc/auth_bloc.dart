import 'package:clean/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp; //this must as private

  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp =
            userSignUp, //initializer list becouse private variable should not accessible for outside
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      // _userSignUp.call(UserSignupParms( //we can use like this also or below i give one more methoe
      //   email: event.email,
      //   name: event.name,
      //   password: event.password,
      // ));
      final res = await _userSignUp(UserSignupParms(
        //this is benfit of using call method
        email: event.email,
        name: event.name,
        password: event.password,
      ));

      res.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => AuthSuccess(uid: r));
    });
  }
}
