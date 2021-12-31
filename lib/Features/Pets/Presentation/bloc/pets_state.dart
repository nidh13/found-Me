part of 'pets_bloc.dart';

abstract class PetsState extends Equatable {
  PetsState([List props = const <dynamic>[]]) : super(props);
}

class EmptyPetsState extends PetsState {}

class LoadingPetsState extends PetsState {}

class LoadingPetsFileState extends PetsState {
  final Profile profile;
  final int index;
String loading;
  LoadingPetsFileState({
    @required this.profile,
    @required this.index,
     @required this.loading,
  }) : super([profile, index]);
}

class ErrorPetsState extends PetsState {
  final Profile profile;

  ErrorPetsState({@required this.profile});
}

class GoToViewProfilePetsState extends PetsState {
  final Profile profile;
  final int index;

  GoToViewProfilePetsState({@required this.profile, @required this.index});
}

class GoToHomeScreenState extends PetsState {
  final Profile profile;
  GoToHomeScreenState({
    @required this.profile,
  });
}

class GoToSerialNumberToPetTagState extends PetsState {
  final Profile profile;
  final int index;

  GoToSerialNumberToPetTagState({@required this.profile, @required this.index});
}

class AddTagPetsState extends PetsState {
  final Profile profile;
  final int index;

  AddTagPetsState({@required this.profile, @required this.index});
}

class GoToEditProfilePetsState extends PetsState {
  final Profile profile;
  final int index;

  GoToEditProfilePetsState({@required this.profile, @required this.index});
}
