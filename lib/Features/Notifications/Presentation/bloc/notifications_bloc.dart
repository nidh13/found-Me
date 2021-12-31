import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Notifications/Domain/Usecases/editNotifications.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, Notificationstate> {
  final EditNotifications editNotifications;

  NotificationsBloc({
    @required this.editNotifications,
  });

  @override
  Notificationstate get initialState => EmptyNotificationsState();

  @override
  Stream<Notificationstate> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is GoToNotificationsEvent) {
      yield GoToNotoficationState(
        profile: event.profile,
      );
    }

    if (event is GoToDeleteNotifEvent) {
      yield LoadingNotifState();
      EditNotificationsParams editNotificationsParams = EditNotificationsParams(
        profile: event.profile,
        index: event.index,
      );
      final failureOrToken = await editNotifications(editNotificationsParams);
      yield* failureOrToken.fold((failure) async* {
        yield GoToNotoficationState(
          profile: event.profile,
        );
      }, (profile) async* {
        yield GoToNotoficationState(profile: profile);
      });
    }
  }
}
