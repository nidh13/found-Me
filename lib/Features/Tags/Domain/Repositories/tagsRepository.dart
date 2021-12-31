import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class TagsRepository {
  Future<Either<Failure, Profile>> addEditObjectTag(
      AddEditTagParams addEditTagParams);
  Future<Either<Failure, Profile>> filterTags(Profile profile);
  Future<Either<Failure, Profile>> uploadFile(
      AddEditObjectTagParams addEditObjectTagParams);
/*   Future<Either<Failure, Profile>> listTags(Profile profile); */
  Future<Either<Failure, Profile>> verifyTag(Profile profile);
}
