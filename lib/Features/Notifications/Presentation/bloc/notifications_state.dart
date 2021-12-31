part of 'notifications_bloc.dart';

abstract class Notificationstate extends Equatable {
  Notificationstate([List props = const <dynamic>[]]) : super(props);
}

class EmptyNotificationsState extends Notificationstate {}

class LoadingNotifState extends Notificationstate {}

/* 
class ErrorHelpState extends Notificationstate {
  final Profile profile;

  ErrorHelpState({
    @required this.profile,
  }) : super([profile]);
} 
 */
class GoToDeleteNotifState extends Notificationstate {
  final Profile profile;

  GoToDeleteNotifState({
    @required this.profile,
  }) : super([profile]);
}

class GoToNotoficationState extends Notificationstate {
  final Profile profile;

  GoToNotoficationState({
    @required this.profile,
  }) : super([profile]);
}
