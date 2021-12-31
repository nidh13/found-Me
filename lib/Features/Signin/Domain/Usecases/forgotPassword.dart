import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';

class ForgotPassword implements Usescases<String, String> {
  final UserRepository userRepository;

  ForgotPassword(this.userRepository);

  @override
  Future<Either<Failure, String>> call(String email) async {
    return await userRepository.forgotPassword(email);
  }
}
