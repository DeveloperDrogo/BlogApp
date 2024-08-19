import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failure.dart';
import 'package:clean/core/network/connection_checker.dart';
import 'package:clean/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:clean/core/common/entities/user.dart';
import 'package:clean/features/auth/data/model/userModel.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthoRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthoRepositoryImpl(this.authRemoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authRemoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('user not logged in'));
        }

        return right(UserModel(
            id: session.user.id, email: session.user.email!, password: ''));
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('user not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmail(
      {required String email, required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No internet connected'));
      }
      final user = await authRemoteDataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signupWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No internet connected'));
      }
      final user = await authRemoteDataSource.signupWithEmailAndPassword(
        email: email,
        name: name,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
