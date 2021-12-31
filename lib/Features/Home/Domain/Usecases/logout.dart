import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Home/Domain/Repositories/homeRepository.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class Logout implements Usescases<String, Profile> {
  final HomeRepository homeRepository;

  Logout(this.homeRepository);

  @override
  Future<Either<Failure, String>> call(Profile profile) async {
    return await homeRepository.logout(profile);
  }
}
