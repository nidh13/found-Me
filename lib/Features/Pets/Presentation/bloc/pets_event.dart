part of 'pets_bloc.dart';

abstract class PetsEvent extends Equatable {
  PetsEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToViewProfilePetEvent extends PetsEvent {
  final Profile profile;
  final int index;

  GoToViewProfilePetEvent({@required this.profile, @required this.index});
}

class GoToEditProfilePetDisplayEvent extends PetsEvent {
  final Profile profile;
  final int index;

  GoToEditProfilePetDisplayEvent(
      {@required this.profile, @required this.index});
}

class GoToEditProfilePetEvent extends PetsEvent {
  final Profile profile;
  final int index;

  GoToEditProfilePetEvent({@required this.profile, @required this.index});
}

class GoToHomeEvent extends PetsEvent {
  final Profile profile;

  GoToHomeEvent({
    @required this.profile,
  });
}

class GoToSerialNumberToPetTagEvent extends PetsEvent {
  final Profile profile;
  final int index;

  GoToSerialNumberToPetTagEvent({@required this.profile, @required this.index});
}

class UploadFilePetEvent extends PetsEvent {
  final Profile profile;
  final int index;
  UploadFilePetEvent({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}

class AddTagPetsEvent extends PetsEvent {
  final Profile profile;
  final int index;
  AddTagPetsEvent({
    @required this.profile,
    @required this.index,
  }) : super([profile]);
}
