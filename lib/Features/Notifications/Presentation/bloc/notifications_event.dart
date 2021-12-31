part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  NotificationsEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToNotificationsEvent extends NotificationsEvent {
  final Profile profile;

  GoToNotificationsEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToDeleteNotifEvent extends NotificationsEvent {
  final Profile profile;
  final int index;

  GoToDeleteNotifEvent({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}
