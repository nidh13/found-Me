part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToHomeEvent extends HomeEvent {
  final Profile profile;

  GoToHomeEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewProfileEvent extends HomeEvent {
  final Profile profile;

  GoToViewProfileEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditProfileEvent extends HomeEvent {
  final Profile profile;

  GoToEditProfileEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditPetsEvent extends HomeEvent {
  final Profile profile;

  GoToEditPetsEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewObjectTagEvent extends HomeEvent {
  final Profile profile;

  GoToViewObjectTagEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditObjectTagEvent extends HomeEvent {
  final Profile profile;

  GoToEditObjectTagEvent({
    @required this.profile,
  }) : super([profile]);
}

class LogoutEvent extends HomeEvent {
  final Profile profile;

  LogoutEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToAddEditObjectTagEvent extends HomeEvent {
  final Profile profile;

  GoToAddEditObjectTagEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToAddEditObjectHomeTagEvent extends HomeEvent {
  final Profile profile;
  final int index;

  GoToAddEditObjectHomeTagEvent({@required this.profile, @required this.index});
}

class GoToSwitchObjectTagEvent extends HomeEvent {
  final Profile profile;

  GoToSwitchObjectTagEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToListingTagEvent extends HomeEvent {
  final Profile profile;
  final viewTag;
  GoToListingTagEvent({@required this.profile, @required this.viewTag})
      : super([profile]);
}

class GoToResetPasswordEvent extends HomeEvent {
  final Profile profile;

  GoToResetPasswordEvent({
    @required this.profile,
  }) : super([profile]);
}

class ResetPasswordEvent extends HomeEvent {
  final ResetPasswordParams resetPasswordParams;

  ResetPasswordEvent({
    @required this.resetPasswordParams,
  }) : super([resetPasswordParams]);
}

class GoToMessagesEvent extends HomeEvent {
  final Profile profile;

  GoToMessagesEvent({
    @required this.profile,
  }) : super([profile]);
}
