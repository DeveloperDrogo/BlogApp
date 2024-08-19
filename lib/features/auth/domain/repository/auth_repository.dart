import 'package:clean/core/error/failure.dart';
import 'package:clean/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure,User>> signupWithEmail({
    required String name,
    required String email,
    required String password,
  });
  
  Future<Either<Failure,User>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure,User>> currentUser();
}