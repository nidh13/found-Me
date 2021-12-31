import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Features/Profile/Domain/Usecases/editProfile.dart';
import 'package:neopolis/Features/Profile/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final EditProfile editProfile;
  final UploadFileProfile uploadFile;

  ProfileBloc({
    @required this.editProfile,
    @required this.uploadFile,
  });

  @override
  ProfileState get initialState => EmptyProfileState();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is GoToViewProfileEvent) {
      yield GoToViewProfileState(
        profile: event.profile,
      );
    }

    if (event is GoToEditProfileEvent) {
      yield GoToEditProfileState(
        profile: event.profile,
      );
    }

    if (event is EditProfileEvent) {
      yield LoadingProfileState();
      final failureOrToken = await editProfile(event.profile);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorProfileState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message == "Error") {
            yield ErrorProfileState(
              profile: profile,
            );
          } else if (profile.parameters.location == "View profile") {
            yield GoToViewProfileState(
              profile: profile,
            );
          } else if (profile.parameters.location == "profile") {
            yield GoToEditProfileState(
              profile: profile,
            );
          } else if (profile.parameters.location == "Edit view profile") {
            yield GoToViewProfileState(
              profile: profile,
            );
          } else if (profile.parameters.location == "Edit profile") {
            yield GoToEditProfileState(
              profile: profile,
            );
          } else if (profile.parameters.location == "view home") {
            yield GoToHomeState(profile: profile);
          }
        },
      );
    }

    if (event is UploadFileEvent) {
      yield LoadingProfileFileState(
        profile: event.profile,
         loading:'true',
      );
      final failureOrToken = await uploadFile(event.profile);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorProfileState(
            profile: event.profile,
           
          );
        },
        (profile) async* {
          yield GoToEditProfileState(
            profile: profile,
          );
        },
      );
    }
  }
}
