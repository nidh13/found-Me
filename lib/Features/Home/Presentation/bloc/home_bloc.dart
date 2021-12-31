import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Home/Domain/Usecases/logout.dart';
import 'package:neopolis/Features/Home/Domain/Usecases/resetPassword.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ResetPassword resetPassword;
  final Logout logout;

  HomeBloc({
    @required this.resetPassword,
    @required this.logout,
  });

  @override
  HomeState get initialState => EmptyHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GoToHomeEvent) {
      yield GoToHomeState(
        profile: event.profile,
      );
    }

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

    if (event is GoToViewObjectTagEvent) {
      yield GoToViewObjectTagState(
        profile: event.profile,
      );
    }

    if (event is GoToAddEditObjectTagEvent) {
      yield GoToAddEditObjectTagState(
        profile: event.profile,
      );
    }

    if (event is GoToAddEditObjectHomeTagEvent) {
      yield GoToAddEditObjectTagHomeState(
        profile: event.profile,
        index: event.index,
      );
    }
    if (event is GoToSwitchObjectTagEvent) {
      yield GoToSwitchObjectTagState(
        profile: event.profile,
      );
    }

    if (event is GoToListingTagEvent) {
      yield GoToListingTagState(
        profile: event.profile,
        viewTag: event.viewTag,
      );
    }

    if (event is GoToEditObjectTagEvent) {
      yield GoToEditObjectTagState(
        profile: event.profile,
      );
    }
    if (event is GoToEditPetsEvent) {
      yield GoToEditProfilePetsState(
        profile: event.profile,
      );
    }

    if (event is GoToResetPasswordEvent) {
      yield GoToResetPasswordState(
        profile: event.profile,
      );
    }

    if (event is GoToMessagesEvent) {
      yield GoToMessagesState(
        profile: event.profile,
      );
    }

    if (event is ResetPasswordEvent) {
      yield LoadingHomeState();
      final resetPasswordParams = ResetPasswordParams(
        profile: event.resetPasswordParams.profile,
        oldPassword: event.resetPasswordParams.oldPassword,
        newPassword: event.resetPasswordParams.newPassword,
      );
      final failureOrToken = await resetPassword(resetPasswordParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorHomeState(
            profile: event.resetPasswordParams.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message == "Error or not modified" ||
              profile.userGeneralInfo.message ==
                  "wrong old password for this user" ||
              profile.userGeneralInfo.message == "request not found" ||
              profile.userGeneralInfo.message ==
                  "Passowrd might include the a-z, A-Z, 0..9. and at least one special character " ||
              profile.userGeneralInfo.message == 'Server internal error') {
            yield ErrorHomeState(
              profile: profile,
            );
          } else {
            yield ResetPasswordState(
              profile: profile,
            );
          }
        },
      );
    }

    if (event is LogoutEvent) {
      yield LoadingHomeState();
      final failureOrToken = await logout(event.profile);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorHomeState(
            profile: event.profile,
          );
        },
        (message) async* {
          if (message == 'Succefully Logout') {
            yield LogoutState(
              message: message,
            );
          } else {
            yield LogoutState(
              message: message,
            );
          }
        },
      );
    }
  }
}
