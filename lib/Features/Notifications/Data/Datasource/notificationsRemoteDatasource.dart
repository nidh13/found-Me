 import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class NotificationsRemoteDataSource {
  Future<Profile> editnotifications( EditNotificationsParams editNotificationsParams);
}
  