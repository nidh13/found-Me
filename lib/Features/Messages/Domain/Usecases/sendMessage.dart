import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Messages/Domain/Repositories/messagesRepository.dart';

class SendMessage implements Usescases<Profile, Profile> {
  final MessagesRepository messagesRepository;

  SendMessage(this.messagesRepository);

  @override
  Future<Either<Failure, Profile>> call(Profile profile) async {
    return await messagesRepository.sendMessage(profile);
  }
}
