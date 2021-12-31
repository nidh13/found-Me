part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  TagsEvent([List props = const <dynamic>[]]) : super(props);
}

class GoToViewObjectTagEvent extends TagsEvent {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;
  GoToViewObjectTagEvent(
      {@required this.profile,
      @required this.type,
      @required this.indexu,
      @required this.index});
}

class GoToSerialNumberToObjectTagEvent extends TagsEvent {
  final Profile profile;

  GoToSerialNumberToObjectTagEvent({@required this.profile});
}

class GoToAddEditObjectTagEvent extends TagsEvent {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;
  GoToAddEditObjectTagEvent(
      {@required this.profile, this.type, this.indexu, @required this.index});
}

class GoToSwitchObjectTagEvent extends TagsEvent {
  final Profile profile;

  GoToSwitchObjectTagEvent({@required this.profile});
}

class VerifyTagEvent extends TagsEvent {
  final Profile profile;

  VerifyTagEvent({@required this.profile});
}

class GoToListingTagEvent extends TagsEvent {
  final Profile profile;

  GoToListingTagEvent({@required this.profile});
}

class GoTogetSwitchObjectTagEvent extends TagsEvent {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;

  GoTogetSwitchObjectTagEvent(
      {@required this.profile,
      @required this.type,
      @required this.indexu,
      @required this.index});
}

class AddEditObjectTagEvent extends TagsEvent {
  final Profile profile;
  final String type;
  final int indexu;

  final int index;

  AddEditObjectTagEvent({
    @required this.profile,
    this.type,
    this.indexu,
    this.index,
  });
}

class ListingTagEvent extends TagsEvent {
  final Profile profile;

  ListingTagEvent({
    @required this.profile,
  }) : super([profile]);
}

class FilterListingTagEvent extends TagsEvent {
  final Profile profile;

  FilterListingTagEvent({
    @required this.profile,
  }) : super([profile]);
}

class GoToViewPetsEvent extends TagsEvent {
  final Profile profile;
  final int index;

  GoToViewPetsEvent({
    @required this.profile,
    @required this.index,
  });
}

class GoToAddEditPetEvent extends TagsState {
  final Profile profile;

  final int index;

  GoToAddEditPetEvent({
    @required this.profile,
    @required this.index,
  });
}

class UploadFileEvent extends TagsEvent {
  final Profile profile;
  final String type;
  final int indexu;

  final int index;
  UploadFileEvent({
    @required this.profile,
    @required this.type,
    @required this.indexu,
    @required this.index,
  }) : super([profile]);
}
