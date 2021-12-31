import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Home/Domain/Repositories/homeRepository.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class ResetPassword implements Usescases<Profile, ResetPasswordParams> {
  final HomeRepository homeRepository;

  ResetPassword(this.homeRepository);

  @override
  Future<Either<Failure, Profile>> call(
      ResetPasswordParams resetPasswordParams) async {
    return await homeRepository.resetPassword(resetPasswordParams);
  }
}
