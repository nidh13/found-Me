part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  MessagesEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToHomeEvent extends MessagesEvent {
  final Profile profile;

  GoToHomeEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToSpecificMessageEvent extends MessagesEvent {
  final Profile profile;

  GoToSpecificMessageEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToMessagesEvent extends MessagesEvent {
  final Profile profile;

  GoToMessagesEvent({
    @required this.profile,
  }) : super([profile]);
}

class SendMessageEvent extends MessagesEvent {
  final Profile profile;

  SendMessageEvent({
    @required this.profile,
  }) : super([profile]);
}

class DeleteDiscussionEvent extends MessagesEvent {
  final Profile profile;

  DeleteDiscussionEvent({
    @required this.profile,
  }) : super([profile]);
}
