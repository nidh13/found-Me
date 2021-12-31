import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class HomeRepository {
  Future<Either<Failure, Profile>> resetPassword(
      ResetPasswordParams resetPasswordParams);
  Future<Either<Failure, String>> logout(Profile profile);
}
