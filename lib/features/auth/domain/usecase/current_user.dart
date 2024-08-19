import 'package:clean/core/error/failure.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/core/common/entities/user.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParms> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParms parms) async {
    return await authRepository.currentUser();
  }
}
