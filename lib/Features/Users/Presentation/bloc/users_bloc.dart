import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/DeleteSubUser.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/editProfileSubUser.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UploadFileSubUsers uploadFile;
  final EditProfileSubUser editProfileSubUser;
  final DeleteProfileSubUser deleteProfileSubUser;
  UsersBloc({
    @required this.uploadFile,
    @required this.editProfileSubUser,
    @required this.deleteProfileSubUser,
  });

  @override
  UsersState get initialState => EmptyUsersState();

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is GoToAddNewUserEvent) {
      yield GoToAddNewUserState(
        profile: event.profile,
      );
    }

    if (event is GoToAddPictureToNewUserEvent) {
      yield GoToAddPictureToNewUserState(
        profile: event.profile,
      );
    }
    if (event is GoToEditProfileSubUserEvent) {
      yield GoToEditProfileSubUserState(
          profile: event.profile, index: event.index);
    }
    if (event is GoToViewProfileSubUserEvent) {
      yield GoToViewProfileSubUserDisplayState(
          profile: event.profile, index: event.index);
    }

    if (event is GoToEditPictureToNewUserEvent) {
      yield GoToEditPictureToNewUserState(
        profile: event.profile,
      );
    }
    if (event is DeleteProfileSubUserEvent) {
      AddEditUsersParams addEditUsersParams = AddEditUsersParams(
        profile: event.profile,
        index: event.index,
      );
      yield LoadingUsersState();
      final failureOrToken = await deleteProfileSubUser(addEditUsersParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorUsersState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message == "Error") {
            yield ErrorUsersState(
              profile: profile,
            );
          } else {
            yield GoToHomeScreenState(
              profile: profile,
            );
          }
        },
      );
    }
    if (event is EditProfileEvent) {
      AddEditUsersParams addEditUsersParams = AddEditUsersParams(
        profile: event.profile,
        index: event.index,
      );
      yield LoadingUsersState();
      final failureOrToken = await editProfileSubUser(addEditUsersParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorUsersState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message == "Error") {
            yield ErrorUsersState(
              profile: profile,
            );
          } else if (profile.userGeneralInfo.subUsers[event.index]
                  .userGeneralInfo.active ==
              1) {
            if (profile.parameters.location == 'view sub user') {
              yield GoToViewProfileSubUserDisplayState(
                  profile: profile, index: event.index);
            } else if (profile.parameters.location == 'view save user') {
              yield GoToViewProfileSubUserDisplayState(
                  profile: profile, index: event.index);
            } else {
              yield GoToEditProfileSubUserState(
                  profile: profile, index: event.index);
            }
          } else {
            if (profile.userGeneralInfo.subUsers[event.index].userGeneralInfo
                    .active ==
                0) {
              profile.userGeneralInfo.subUsers.removeAt(event.index);
            }
            yield GoToHomeScreenState(
              profile: profile,
            );
          }
        },
      );
    }
    if (event is UploadFileEvent) {
      yield LoadingEditUsersState(
        profile: event.profile,
        index: event.index,
        loading :'true'
      );
      AddEditUploadFileUsersParams addEditUploadFileUsersParams =
          AddEditUploadFileUsersParams(
        profile: event.profile,
        index: event.index,
      );
      final failureOrToken = await uploadFile(addEditUploadFileUsersParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorUsersState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.parameters.location == 'ProfilePictureSubUser') {
            yield GoToEditPictureToNewUserState(
              profile: profile,
            );
          } else if (profile.parameters.location == 'EditProfilePicture') {
            yield GoToEditPictureToNewUserState(
              profile: profile,
            );
          } else {
            yield GoToEditProfileSubUserState(
                profile: profile, index: event.index);
          }
        },
      );
    }
  }
}
