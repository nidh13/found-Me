/* import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Domain/Repositories/tagsRepository.dart';

class ListTags implements Usescases<Profile, Profile> {
  final TagsRepository tagsRepository;

  ListTags(this.tagsRepository);

  @override
  Future<Either<Failure, Profile>> call(Profile profile) async {
    return await tagsRepository.listTags(profile);
  }
}
 */