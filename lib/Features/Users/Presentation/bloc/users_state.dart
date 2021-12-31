part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  UsersState([List props = const <dynamic>[]]) : super(props);
}

class LoadingUsersState extends UsersState {}

class LoadingEditUsersState extends UsersState {
  final Profile profile;
  final int index;
  final String loading;
  LoadingEditUsersState({@required this.profile, @required this.index,@required this.loading})
      : super([profile]);
}

class InitialState extends UsersState {}

class ErrorUsersState extends UsersState {
  final Profile profile;

  ErrorUsersState({
    @required this.profile,
  }) : super([profile]);
}

class DeleteProfileSubUserState extends UsersEvent {
  final Profile profile;
  final int index;
  DeleteProfileSubUserState({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}

class GoToAddNewUserState extends UsersState {
  final Profile profile;

  GoToAddNewUserState({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditProfileSubUserState extends UsersState {
  final Profile profile;
  final int index;
  GoToEditProfileSubUserState({@required this.profile, @required this.index})
      : super([profile]);
}

class EmptyUsersState extends UsersState {}

class LoadingProfileState extends UsersState {}

class GoToAddPictureToNewUserState extends UsersState {
  final Profile profile;

  GoToAddPictureToNewUserState({
    @required this.profile,
  }) : super([profile]);
}

class GoToHomeScreenState extends UsersState {
  final Profile profile;

  GoToHomeScreenState({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewProfileSubUserDisplayState extends UsersState {
  final Profile profile;
  final int index;
  GoToViewProfileSubUserDisplayState({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}

class GoToEditPictureToNewUserState extends UsersState {
  final Profile profile;

  GoToEditPictureToNewUserState({
    @required this.profile,
  }) : super([profile]);
}
