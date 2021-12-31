import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/listMessages.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/goToSpecificMessage.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/sendMessage.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/deleteDiscussion.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

part 'Messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final ListMessages listMessages;
  final GoToSpecificMessage goToSpecificMessage;
  final SendMessage sendMessage;
  final DeleteDiscussion deleteDiscussion;

  MessagesBloc({
    @required this.listMessages,
    @required this.goToSpecificMessage,
    @required this.sendMessage,
    @required this.deleteDiscussion,
  });

  @override
  MessagesState get initialState => EmptyMessagesState();

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    if (event is GoToHomeEvent) {
      yield GoToHomeState(
        profile: event.profile,
      );
    }

    if (event is GoToMessagesEvent) {
      yield LoadingMessagesState();
      final failureOrToken = await listMessages(event.profile);
      yield* failureOrToken.fold((failure) async* {
        yield ErrorMessagesState(
          profile: event.profile,
        );
      }, (profile) async* {
        yield GoToMessagesState(
          profile: profile,
        );
      });
    }

    if (event is GoToSpecificMessageEvent) {
      yield LoadingMessagesState();
      final failureOrToken = await goToSpecificMessage(event.profile);
      yield* failureOrToken.fold((failure) async* {
        yield ErrorMessagesState(
          profile: event.profile,
        );
      }, (profile) async* {
        yield GoToSpecificMessageState(
          profile: profile,
        );
      });
    }

    if (event is SendMessageEvent) {
      if (event.profile.parameters.specificMessage.isFile) {
        yield LoadingSendMessagesState(
          profile: event.profile,
        );
        final failureOrToken = await sendMessage(event.profile);
        yield* failureOrToken.fold((failure) async* {
          yield ErrorMessagesState(
            profile: event.profile,
          );
        }, (profile) async* {
          yield SendMessageState(
            profile: profile,
          );
        });
      } else {
        final failureOrToken = await sendMessage(event.profile);
        yield* failureOrToken.fold((failure) async* {
          yield ErrorMessagesState(
            profile: event.profile,
          );
        }, (profile) async* {
          // yield SendMessageState(
          //   profile: profile,
          // );
        });
      }
    }

    if (event is DeleteDiscussionEvent) {
      final failureOrToken = await deleteDiscussion(event.profile);
      yield* failureOrToken.fold((failure) async* {
        yield ErrorMessagesState(
          profile: event.profile,
        );
      }, (profile) async* {
        yield GoToMessagesState(
          profile: profile,
        );
      });
    }
  }
}
