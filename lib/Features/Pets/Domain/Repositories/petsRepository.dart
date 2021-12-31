import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class PetsRepository {
  Future<Either<Failure, Profile>> uploadFilePets(
      AddEditUploadFilePetsParams addEditUploadFilePetsParams);
  Future<Either<Failure, Profile>> editProfilePets(
      AddEditUploadFilePetsParams addEditPetsParams);
  Future<Either<Failure, Profile>> addTagPets(
      AddEditUploadFilePetsParams addEditPetsParams);
}
