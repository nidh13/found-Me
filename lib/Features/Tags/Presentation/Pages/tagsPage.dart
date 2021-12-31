import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/addEditObjectTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/getSwitchObjectTag.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/serialNumberToObjectTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/viewObjectTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/switchObjectTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/listingTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/TestTag.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/viewPetProfileDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';

class TagsPage extends StatelessWidget {
  final Profile profile;
  final String viewTag;
  const TagsPage({Key key, @required this.profile, @required this.viewTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        if (state is GoToSerialNumberToObjectTagState) {
          return SerialNumberToObjectTagDisplay(
            profile: profile,
          );
        }

        if (state is GoToAddEditObjectTagState) {
          return AddEditObjectTagDisplay(
            profile: state.profile,
            type: state.type,
            indexu: state.indexu,
            index: state.index,
          );
        }

        if (state is ViewProfilePetState) {
          return ViewProfilePetDisplay(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is GoToAddEditPetState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/petsProvider',
              arguments: {
                'profile': state.profile,
                'index': state.index,
                'route': 'GoToAddEditPetProfile'
              },
            );
          });
        }
        if (state is GoToViewObjectTagState) {
          return ViewObjectTagDisplay(
            profile: state.profile,
            type: state.type,
            indexu: state.indexu,
            index: state.index,
          );
        }
        if (state is ErrorObjectTagState) {
          // return SerialNumberToObjectTagDisplay(
          //   profile: state.profile,
          //   index: state.index,
          // );
        }

        if (state is EmptyObjectTagState) {
          if (profile.parameters.location == "Switch Tag") {
            return SwitchObjectTag(
              profile: profile,
            );
          }
          if (profile.parameters.location == "Add Tag") {
            return SerialNumberToObjectTagDisplay(
              profile: profile,
            );
          }
          if (profile.parameters.location == "Test Tag") {
            return TestTagDisplay(
              profile: profile,
            );
          }
          if (profile.parameters.location == "AddEditTag") {
            return AddEditObjectTagDisplay(
              profile: profile,
              type: profile.parameters.typecheck,
              indexu: profile.parameters.indexu,
              index: profile.parameters.indext,
            );
          }
          if (profile.parameters.location == 'VerifyTag') {
            BlocProvider.of<TagsBloc>(context).dispatch(
              VerifyTagEvent(
                profile: profile,
              ),
            );
          }
           if (profile.parameters.location == 'SaveTag') {
            BlocProvider.of<TagsBloc>(context).dispatch(
              AddEditObjectTagEvent(
                profile: profile,
                type: profile.parameters.typecheck,
                index: profile.parameters.indext,
                indexu: profile.parameters.indexu,
              ),
            );}
             if (profile.parameters.location == 'Cancel') {
            BlocProvider.of<TagsBloc>(context).dispatch(
              AddEditObjectTagEvent(
                profile: profile,
                type: profile.parameters.typecheck,
                index: profile.parameters.indext,
                indexu: profile.parameters.indexu,
              ),
            );}
          
          if (profile.parameters.location == 'DeleteTag') {
            BlocProvider.of<TagsBloc>(context).dispatch(
              AddEditObjectTagEvent(
                profile: profile,
                type: profile.parameters.typecheck,
                index: profile.parameters.indext,
                indexu: profile.parameters.indexu,
              ),
            );
          }
          if (profile.parameters.location == "My Tags: View / Edit / Del") {
            String viewTags;
            profile.parameters.viewTag != null
                ? viewTags = profile.parameters.viewTag
                : viewTags = ' ';
            print(viewTags);
            return ListingTag(
              profile: profile,
              viewtypeTag: viewTags,
            );
          }
        }

        if (state is GoTogetSwitchObjectTagState) {
          return GetSwitchObjectTagDisplay(
            profile: state.profile,
            type: state.type,
            indexu: state.indexu,
            index: state.index,
          );
        }
if (state is GoToViewPetTagState){
            WidgetsBinding.instance.addPostFrameCallback((_) {

  Navigator.of(context).pushReplacementNamed(
      '/petsProvider',
      arguments: {
        'profile':state. profile,
        'index': state.index,
        'route': 'GoToViewPetProfile',
      },
    );   });
}
        if (state is VerifyTagState) {
          if (state.profile.parameters.statuscheck == true) {
            state.profile.userGeneralInfo.message = "Tag not found ";
            return SerialNumberToObjectTagDisplay(profile: state.profile);
          } else {
            /*     state.profile.userGeneralInfo.tagsList. */

            return AddEditObjectTagDisplay(
              profile: state.profile,
              type: state.type,
              indexu: state.indexu,
              index: state.index,
            );
            /*        return  SerialNumberToObjectTagDisplay(profile:state.profile) */

          }
        }

        if (state is AddEditObjectTagState) {
          if (state.profile.userGeneralInfo.message ==
              'An error occured while updating !') {
            return AddEditObjectTagDisplay(
              profile: state.profile,
              type: state.type,
              indexu: state.indexu,
              index: state.index,
            );
          } else {
            return AddEditObjectTagDisplay(
              profile: state.profile,
              type: state.type,
              indexu: state.indexu,
              index: state.index,
            );
          }
        }
        if (state is ViewProfilePetDisplay) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/petsProvider',
              arguments: profile,
            );
          });
        }

        if (state is LoadingObjectTagFileState) {
          return AddEditObjectTagDisplay(
            profile: state.profile,
            type: state.type,
            indexu: state.indexu,
            index: state.index,
            loading: state.loading,
          );
        }
        if (state is SwitchFilterTagState) {
          return SwitchObjectTag(
            profile: profile,
          );
        }
        if (state is ListingFilterTagState) {
          return ListingTag(
            profile: profile,
            viewtypeTag: '',
          );
        }
        return LoadingWidget();
      },
    );
  }
}
