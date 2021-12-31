import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class UsersRepository {
  Future<Either<Failure, Profile>> uploadFile(
      AddEditUploadFileUsersParams addEditUploadFileUsersParams);
  Future<Either<Failure, Profile>> editProfileSUbUser(
      AddEditUsersParams addEditTagParams);
  Future<Either<Failure, Profile>> deleteProfileSubUser(
      AddEditUsersParams addEditUploadFileUsersParams);
}
