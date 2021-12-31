import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class NotificationsRepository {
 Future<Either<Failure, Profile>> editNotifications(  EditNotificationsParams editNotifcationsParams);
}
