import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Notifications/Domain/Repositories/notificationsRepository.dart';


class EditNotifications implements Usescases<Profile, EditNotificationsParams> {
  final NotificationsRepository usersRepository;

  EditNotifications(this.usersRepository);

  @override
  Future<Either<Failure, Profile>> call(EditNotificationsParams addNotificationsParams) async {
    return await usersRepository.editNotifications(addNotificationsParams);
  }
} 