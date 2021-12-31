import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class PetsRemoteDataSource {
  Future<Profile> editProfilePets(
      AddEditUploadFilePetsParams addEditPetsParams);
  Future<Profile> uploadFilePets(
      AddEditUploadFilePetsParams addEditUploadFilePetsParams);
  Future<Profile> addTagPets(
      AddEditUploadFilePetsParams addEditUploadFilePetsParams);
}
