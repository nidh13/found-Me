import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Tags/Domain/Repositories/tagsRepository.dart';

class UploadFileObjectTag
    implements Usescases<Profile, AddEditObjectTagParams> {
  final TagsRepository tagsRepository;

  UploadFileObjectTag(this.tagsRepository);

  @override
  Future<Either<Failure, Profile>> call(
      AddEditObjectTagParams addEditObjectTagParams) async {
    return await tagsRepository.uploadFile(addEditObjectTagParams);
  }
}
