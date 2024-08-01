import 'package:clean/core/error/failure.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<String, UserSignupParms> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignupParms parms) async{
    return await authRepository.signupWithEmail(
      name: parms.name,
      email: parms.email,
      password: parms.password,
    );
  }
}

class UserSignupParms {
  final String email;
  final String name;
  final String password;

  UserSignupParms(
      {required this.email, required this.name, required this.password});
}
