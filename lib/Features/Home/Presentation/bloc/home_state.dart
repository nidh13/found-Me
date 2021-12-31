part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const <dynamic>[]]) : super(props);
}

class EmptyHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final Profile profile;

  ErrorHomeState({
    @required this.profile,
  }) : super([profile]);
}

class GoToHomeState extends HomeState {
  final Profile profile;

  GoToHomeState({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewProfileState extends HomeState {
  final Profile profile;

  GoToViewProfileState({
    @required this.profile,
  }) : super([profile]);
}

class GoToAddEditObjectTagHomeState extends HomeState {
  final Profile profile;
  final int index;

  GoToAddEditObjectTagHomeState({@required this.profile, @required this.index});
}

class GoToAddEditObjectTagState extends HomeState {
  final Profile profile;

  GoToAddEditObjectTagState({@required this.profile});
}

class GoToEditProfileState extends HomeState {
  final Profile profile;

  GoToEditProfileState({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditProfilePetsState extends HomeState {
  final Profile profile;

  GoToEditProfilePetsState({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewObjectTagState extends HomeState {
  final Profile profile;

  GoToViewObjectTagState({
    @required this.profile,
  }) : super([profile]);
}

class GoToSwitchObjectTagState extends HomeState {
  final Profile profile;

  GoToSwitchObjectTagState({
    @required this.profile,
  }) : super([profile]);
}

class GoToListingTagState extends HomeState {
  final Profile profile;
  final String viewTag;

  GoToListingTagState({@required this.profile, @required this.viewTag})
      : super([profile]);
}

class GoToEditObjectTagState extends HomeState {
  final Profile profile;

  GoToEditObjectTagState({
    @required this.profile,
  }) : super([profile]);
}

class LogoutState extends HomeState {
  final String message;

  LogoutState({
    @required this.message,
  }) : super([message]);
}

class GoToResetPasswordState extends HomeState {
  final Profile profile;

  GoToResetPasswordState({
    @required this.profile,
  }) : super([profile]);
}

class ResetPasswordState extends HomeState {
  final Profile profile;

  ResetPasswordState({
    @required this.profile,
  }) : super([profile]);
}

class GoToMessagesState extends HomeState {
  final Profile profile;

  GoToMessagesState({
    @required this.profile,
  }) : super([profile]);
}
