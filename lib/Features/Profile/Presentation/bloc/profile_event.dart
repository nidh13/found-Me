part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToViewProfileEvent extends ProfileEvent {
  final Profile profile;

  GoToViewProfileEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditProfileEvent extends ProfileEvent {
  final Profile profile;

  GoToEditProfileEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToHomeEvent extends ProfileEvent {
  final Profile profile;

  GoToHomeEvent({
    @required this.profile,
  }) : super([profile]);
}

class EditProfileEvent extends ProfileEvent {
  final Profile profile;

  EditProfileEvent({
    @required this.profile,
  }) : super([profile]);
}

class UploadFileEvent extends ProfileEvent {
  final Profile profile;
  UploadFileEvent({
    @required this.profile,
  }) : super([profile]);
}
