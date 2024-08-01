import 'package:clean/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType,Parms>{
  Future<Either<Failure,SuccessType>> call(Parms parms);
}

//SuccessType is get from bloc and also Parms means parameter we can pass eany paramter isnide function