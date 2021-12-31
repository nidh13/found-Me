part of 'reminders_bloc.dart';

abstract class RemindersEvent extends Equatable {
  RemindersEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToViewReminderListEvent extends RemindersEvent {
  final Profile profile;
  GoToViewReminderListEvent({
    @required this.profile,
  }) : super([profile]);
}

class DeleteReminderEvent extends RemindersEvent {
  final Profile profile;
  final Reminders reminders;
  DeleteReminderEvent({
    @required this.profile,
    @required this.reminders,
  }) : super([profile]);
}

class HomeScreenEvent extends RemindersEvent {
  final Profile profile;

  HomeScreenEvent({
    @required this.profile,
  }) : super([profile]);
}
