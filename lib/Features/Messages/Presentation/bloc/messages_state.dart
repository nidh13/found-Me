part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  MessagesState([List props = const <dynamic>[]]) : super(props);
}

class EmptyMessagesState extends MessagesState {}

class LoadingMessagesState extends MessagesState {}

class LoadingSendMessagesState extends MessagesState {
  final Profile profile;

  LoadingSendMessagesState({
    @required this.profile,
  }) : super([profile]);
}

class ErrorMessagesState extends MessagesState {
  final Profile profile;

  ErrorMessagesState({
    @required this.profile,
  }) : super([profile]);
}

class GoToHomeState extends MessagesState {
  final Profile profile;

  GoToHomeState({
    @required this.profile,
  }) : super([profile]);
}

class GoToSpecificMessageState extends MessagesState {
  final Profile profile;

  GoToSpecificMessageState({
    @required this.profile,
  }) : super([profile]);
}

class GoToMessagesState extends MessagesState {
  final Profile profile;

  GoToMessagesState({
    @required this.profile,
  }) : super([profile]);
}

class SendMessageState extends MessagesState {
  final Profile profile;

  SendMessageState({
    @required this.profile,
  }) : super([profile]);
}

class DeleteDiscussionState extends MessagesState {
  final Profile profile;

  DeleteDiscussionState({
    @required this.profile,
  }) : super([profile]);
}
