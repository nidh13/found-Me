import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';

class LoginFacebook implements Usescases<Profile, String> {
  final UserRepository userRepository;

  LoginFacebook(this.userRepository);

  @override
  Future<Either<Failure, Profile>> call(String test) async {
    return await userRepository.loginFacebook(test);
  }
}
