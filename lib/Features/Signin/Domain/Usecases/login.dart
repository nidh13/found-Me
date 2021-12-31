import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';

class Login implements Usescases<Profile, LoginParams> {
  final UserRepository userRepository;

  Login(this.userRepository);

  @override
  Future<Either<Failure, Profile>> call(LoginParams loginParams) async {
    return await userRepository.login(loginParams);
  }
}
