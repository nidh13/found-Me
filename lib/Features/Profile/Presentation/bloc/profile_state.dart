part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  ProfileState([List props = const <dynamic>[]]) : super(props);
}

class EmptyProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class LoadingProfileFileState extends ProfileState {
  final Profile profile;
String loading;
  LoadingProfileFileState({
    @required this.profile,
      this.loading,
  }) : super([profile]);
}

class ErrorProfileState extends ProfileState {
  final Profile profile;

  ErrorProfileState({
    @required this.profile,
  
  }) : super([profile]);
}

class GoToViewProfileState extends ProfileState {
  final Profile profile;

  GoToViewProfileState({
    @required this.profile,
  }) : super([profile]);
}

class GoToEditProfileState extends ProfileState {
  final Profile profile;

  GoToEditProfileState({
    @required this.profile,
  }) : super([profile]);
}

class GoToHomeState extends ProfileState {
  final Profile profile;

  GoToHomeState({
    @required this.profile,
  }) : super([profile]);
}

class EditProfileState extends ProfileState {
  final Profile profile;

  EditProfileState({
    @required this.profile,
  }) : super([profile]);
}

class UploadFileState extends ProfileState {
  final Profile profile;

  UploadFileState({
    @required this.profile,
  }) : super([profile]);
}
