import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class UsersRemoteDataSource {
  Future<Profile> editProfileSubUser(AddEditUsersParams addEditUsersParams);
  Future<Profile> deleteProfileSubUser(AddEditUsersParams addEditUsersParams);

  Future<Profile> uploadFile(
      AddEditUploadFileUsersParams addEditUploadFileUsersParams);
}
