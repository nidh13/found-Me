import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

abstract class ReminderRemoteDataSource {
  Future<Profile> reminderList(DeteleReminderParams deteleReminderParams);
}
