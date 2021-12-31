import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Reminders/Domain/Repositories/reminderRepository.dart';

class ReminderList implements Usescases<Profile, DeteleReminderParams> {
  final ReminderRepository reminderRepository;

  ReminderList(this.reminderRepository);

  @override
  Future<Either<Failure, Profile>> call(
      DeteleReminderParams deteleReminderParams) async {
    return await reminderRepository.reminderList(deteleReminderParams);
  }
}
