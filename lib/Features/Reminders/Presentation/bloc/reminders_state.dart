part of 'reminders_bloc.dart';

abstract class RemindersState extends Equatable {
  RemindersState([List props = const <dynamic>[]]) : super(props);
}

class LoadingReminderState extends RemindersState {}

class InitialState extends RemindersState {}

class ErrorReminderState extends RemindersState {
  final Profile profile;

  ErrorReminderState({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewReminderListState extends RemindersState {
  final Profile profile;

  GoToViewReminderListState({
    @required this.profile,
  }) : super([profile]);
}

class DeleteReminderState extends RemindersEvent {
  final Profile profile;
  final Reminders reminders;
  DeleteReminderState({
    @required this.profile,
    @required this.reminders,
  }) : super([profile]);
}

class EmptyReminderState extends RemindersState {}

class GoToHomeScreenState extends RemindersState {
  final Profile profile;

  GoToHomeScreenState({
    @required this.profile,
  }) : super([profile]);
}
