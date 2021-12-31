part of 'help_bloc.dart';

abstract class HelpState extends Equatable {
  HelpState([List props = const <dynamic>[]]) : super(props);
}

class EmptyHelpState extends HelpState {}

class LoadingHelpState extends HelpState {}

class ErrorHelpState extends HelpState {
  final Profile profile;

  ErrorHelpState({
    @required this.profile,
  }) : super([profile]);
}

class GoToHelpState extends HelpState {
  final Profile profile;

  GoToHelpState({
    @required this.profile,
  }) : super([profile]);
}
