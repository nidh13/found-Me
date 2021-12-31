import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Profile/Domain/Repositories/profileRepository.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class UploadFileProfile implements Usescases<Profile, Profile> {
  final ProfileRepository profileRepository;

  UploadFileProfile(this.profileRepository);

  @override
  Future<Either<Failure, Profile>> call(Profile profile) async {
    return await profileRepository.uploadFile(profile);
  }
}
