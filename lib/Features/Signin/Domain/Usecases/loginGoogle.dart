import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';

class LoginGoogle implements Usescases<Profile, String> {
  final UserRepository userRepository;

  LoginGoogle(this.userRepository);

  @override
  Future<Either<Failure, Profile>> call(String test) async {
    return await userRepository.loginGoogle(test);
  }
}
