import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class MessagesRepository {
  Future<Either<Failure, Profile>> listMessages(Profile profile);
  Future<Either<Failure, Profile>> goToSpecificMessage(Profile profile);
  Future<Either<Failure, Profile>> sendMessage(Profile profile);
  Future<Either<Failure, Profile>> deleteDiscussion(Profile profile);
}
