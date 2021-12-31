import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class UserRemoteDataSource {
  Future<Profile> login(LoginParams loginParams);
  Future<Profile> loginGoogle(String test);
  Future<Profile> loginFacebook(String test);
  Future<String> register(RegisterParams registerParams);
  Future<String> forgotPassword(String email);
}
