import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Reminders/Domain/Usecases/getReminderList.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/editProfileSubUser.dart';

part 'remindes_event.dart';
part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  final ReminderList reminderList;
  RemindersBloc({
    @required this.reminderList,
  });

  @override
  RemindersState get initialState => EmptyReminderState();

  @override
  Stream<RemindersState> mapEventToState(
    RemindersEvent event,
  ) async* {
    if (event is GoToViewReminderListEvent) {
      yield GoToViewReminderListState(
        profile: event.profile,
      );
    }

    if (event is DeleteReminderEvent) {
      DeteleReminderParams deteleReminderParams = DeteleReminderParams(
        profile: event.profile,
        reminder: event.reminders,
      );
      yield LoadingReminderState();
      final failureOrToken = await reminderList(deteleReminderParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorReminderState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message == "Error") {
            yield ErrorReminderState(
              profile: profile,
            );
          } else {
            yield GoToViewReminderListState(
              profile: profile,
            );
          }
        },
      );
    }
  }
}
