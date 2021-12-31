import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class TagsRemoteDataSource {
  Future<Profile> addEditObjectTag(AddEditTagParams addEditTagParams);
  Future<Profile> uploadFile(AddEditObjectTagParams addEditObjectTagParams);
  Future<Profile> filterTags(Profile profile);
  Future<Profile> listTags(Profile profile);
  Future<Profile> verifyTag(Profile profile);
}
