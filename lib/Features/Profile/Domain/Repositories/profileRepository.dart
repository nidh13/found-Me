import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> editProfile(Profile profile);
  Future<Either<Failure, Profile>> uploadFile(Profile profile);
}
