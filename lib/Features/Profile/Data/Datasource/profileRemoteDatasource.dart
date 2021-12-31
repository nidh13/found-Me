import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> editProfile(Profile profile);
  Future<Profile> uploadFile(Profile profile);
}
