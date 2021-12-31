import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  // final Logout logout;

  // HomeBloc({
  //   @required this.logout,
  // });

  @override
  HelpState get initialState => EmptyHelpState();

  @override
  Stream<HelpState> mapEventToState(
    HelpEvent event,
  ) async* {
    if (event is GoToHelpEvent) {
      yield GoToHelpState(
        profile: event.profile,
      );
    }

    /*
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
    */
  }
}
