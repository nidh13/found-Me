part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  UsersEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToAddNewUserEvent extends UsersEvent {
  final Profile profile;

  GoToAddNewUserEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditProfileSubUserEvent extends UsersEvent {
  final Profile profile;
  final int index;
  GoToEditProfileSubUserEvent({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}

class DeleteProfileSubUserEvent extends UsersEvent {
  final Profile profile;
  final int index;
  DeleteProfileSubUserEvent({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}

class GoToAddPictureToNewUserEvent extends UsersEvent {
  final Profile profile;

  GoToAddPictureToNewUserEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewProfileSubUserEvent extends UsersEvent {
  final Profile profile;
  final int index;
  GoToViewProfileSubUserEvent({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}

class GoToEditPictureToNewUserEvent extends UsersEvent {
  final Profile profile;

  GoToEditPictureToNewUserEvent({
    @required this.profile,
  }) : super([profile]);
}

class EditProfileEvent extends UsersEvent {
  final Profile profile;
  final int index;
  EditProfileEvent({@required this.profile, this.index}) : super([profile]);
}

class HomeScreenEvent extends UsersEvent {
  final Profile profile;
  final int index;
  HomeScreenEvent({@required this.profile, this.index}) : super([profile]);
}

class UploadFileEvent extends UsersEvent {
  final Profile profile;
  final index;
  UploadFileEvent({@required this.profile, @required this.index})
      : super([profile]);
}
