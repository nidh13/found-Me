import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class HomeRemoteDataSource {
  Future<Profile> resetPassword(ResetPasswordParams resetPasswordParams);
  Future<String> logout(Profile profile);
}
