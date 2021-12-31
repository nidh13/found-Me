import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';

abstract class Usescases<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
