part of 'tags_bloc.dart';

abstract class TagsState extends Equatable {
  TagsState([List props = const <dynamic>[]]) : super(props);
}

class EmptyObjectTagState extends TagsState {}

class LoadingObjectTagState extends TagsState {}

class LoadingObjectTagFileState extends TagsState {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;
  String loading;
  LoadingObjectTagFileState(
      {@required this.profile,
      @required this.type,
      @required this.indexu,
      @required this.index,
        @required this.loading,
      });
}

class ErrorTagsState extends TagsState {
  final Profile profile;

  ErrorTagsState({@required this.profile});
}

class ErrorObjectTagState extends TagsState {
  final Profile profile;

  ErrorObjectTagState({@required this.profile});
}

class GoToViewObjectTagState extends TagsState {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;

  GoToViewObjectTagState(
      {@required this.profile,
      @required this.type,
      @required this.indexu,
      @required this.index});
}

class GoToAddEditPetState extends TagsState {
  final Profile profile;

  final int index;

  GoToAddEditPetState({
    @required this.profile,
    @required this.index,
  });
}

class GoToSerialNumberToObjectTagState extends TagsState {
  final Profile profile;

  GoToSerialNumberToObjectTagState({@required this.profile});
}

class GoToAddEditObjectTagState extends TagsState {
  final Profile profile;
  final String type;

  final int index;
  final int indexu;

  GoToAddEditObjectTagState(
      {@required this.profile, this.type, @required this.index, this.indexu});
}

class GoToSwitchObjectTagState extends TagsState {
  final Profile profile;

  GoToSwitchObjectTagState({@required this.profile});
}

class VerifyTagState extends TagsState {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;
  VerifyTagState(
      {@required this.profile, this.type, @required this.index, this.indexu});
}

class ListingFilterTagState extends TagsState {
  final Profile profile;

  ListingFilterTagState({
    @required this.profile,
  }) : super([profile]);
}

class SwitchFilterTagState extends TagsState {
  final Profile profile;

  SwitchFilterTagState({
    @required this.profile,
  }) : super([profile]);
}

class GoTogetSwitchObjectTagState extends TagsState {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;

  GoTogetSwitchObjectTagState(
      {@required this.profile,
      @required this.type,
      @required this.indexu,
      @required this.index});
}

class GoToListingTagState extends TagsState {
  final Profile profile;

  GoToListingTagState({@required this.profile});
}
class GoToViewPetTagState extends TagsState {
  final Profile profile;
  final int index;

  GoToViewPetTagState({@required this.profile,@required this.index});
}
class FilterListingTagState extends TagsState {
  final Profile profile;

  FilterListingTagState({@required this.profile});
}

class ViewProfilePetState extends TagsState {
  final Profile profile;
  final int index;

  ViewProfilePetState({
    @required this.profile,
    @required this.index,
  });
}

class AddEditObjectTagState extends TagsState {
  final Profile profile;
  final String type;
  final int indexu;

  final int index;
  AddEditObjectTagState(
      {@required this.profile, this.type, this.indexu, @required this.index});
}
