import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';

class Register implements Usescases<String, RegisterParams> {
  final UserRepository userRepository;

  Register(this.userRepository);

  @override
  Future<Either<Failure, String>> call(RegisterParams registerParams) async {
    return await userRepository.register(registerParams);
  }
}
