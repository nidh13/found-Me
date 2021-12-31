import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Domain/Repositories/tagsRepository.dart';

class AddEditObjectTag implements Usescases<Profile, AddEditTagParams> {
  final TagsRepository tagsRepository;

  AddEditObjectTag(this.tagsRepository);

  @override
  Future<Either<Failure, Profile>> call(
      AddEditTagParams addEditTagParams) async {
    return await tagsRepository.addEditObjectTag(addEditTagParams);
  }
}
