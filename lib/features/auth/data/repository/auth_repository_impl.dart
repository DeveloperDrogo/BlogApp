import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failure.dart';
import 'package:clean/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthoRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthoRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, String>> loginWithEmail(
      {required String email, required String password}) async {
    try {} catch (e) {}
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signupWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await authRemoteDataSource.signupWithEmailAndPassword(
        email: email,
        name: name,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
