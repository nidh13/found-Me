part of 'help_bloc.dart';

abstract class HelpEvent extends Equatable {
  HelpEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToHelpEvent extends HelpEvent {
  final Profile profile;

  GoToHelpEvent({
    @required this.profile,
  }) : super([profile]);
}
