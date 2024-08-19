import 'package:clean/core/error/failure.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/core/common/entities/user.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParms> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParms parms) async {
    return authRepository.loginWithEmail(
      email: parms.email,
      password: parms.password,
    );
  }
}

class UserLoginParms {
  final String email;
  final String password;

  UserLoginParms(this.email, this.password);
}
