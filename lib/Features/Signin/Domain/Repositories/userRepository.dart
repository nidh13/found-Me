import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class UserRepository {
  Future<Either<Failure, Profile>> login(LoginParams loginParams);
  Future<Either<Failure, Profile>> loginGoogle(String test);
  Future<Either<Failure, Profile>> loginFacebook(String test);
  Future<Either<Failure, String>> register(RegisterParams registerParams);
  Future<Either<Failure, String>> forgotPassword(String email);
}
