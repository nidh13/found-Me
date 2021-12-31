import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class MessagesRemoteDataSource {
  Future<Profile> listMessages(Profile profile);
  Future<Profile> goToSpecificMessage(Profile profile);
  Future<Profile> sendMessage(Profile profile);
  Future<Profile> deleteDiscussion(Profile profile);
}
