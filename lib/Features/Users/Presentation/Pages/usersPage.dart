import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/editProfileSubUserDisplay.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/addNewUserDisplay.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/addPictureToNewUserDisplay.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/editPictureToNewUserDisplay.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/ViewProfileSubUserDisplay.dart';

class UsersPage extends StatelessWidget {
  final Profile profile;
  final String route;
  final int index;
  const UsersPage(
      {Key key, @required this.profile, @required this.route, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is EmptyUsersState) {
          if (route == 'GoToAddNewUser') {
            BlocProvider.of<UsersBloc>(context).dispatch(
              GoToAddNewUserEvent(
                profile: profile,
              ),
            );
          }
          if (route == 'GoToEditSubUser') {
            BlocProvider.of<UsersBloc>(context).dispatch(
              GoToViewProfileSubUserEvent(
                profile: profile,
                index: index,
              ),
            );
          }
          if (route == 'GoToViewSubUser') {
            BlocProvider.of<UsersBloc>(context).dispatch(
              GoToViewProfileSubUserEvent(
                profile: profile,
                index: index,
              ),
            );
          }
          if (route == 'GoToSaveSubUser') {
            BlocProvider.of<UsersBloc>(context).dispatch(
              EditProfileEvent(profile: profile, index: index),
            );
          }
          if (route == 'GoToEditViewSubUser') {
            BlocProvider.of<UsersBloc>(context).dispatch(
              GoToEditProfileSubUserEvent(profile: profile, index: index),
            );
          }
        }

        // if (state is InitialState) {
        //   BlocProvider.of<UsersBloc>(context).dispatch(
        //     GoToAddNewUserEvent(
        //       profile: profile,
        //     ),
        //   );
        // }

        if (state is GoToHomeScreenState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
              arguments: state.profile,
            );
          });
        }
        if (state is GoToAddNewUserState) {
          return AddNewUserDisplay(
            profile: state.profile,
          );
        }
        if (state is GoToEditProfileSubUserState) {
          return EditProfileSubUserDisplay(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is GoToAddPictureToNewUserState) {
          return AddPictureToNewUserDisplay(
            profile: state.profile,
          );
        }

        if (state is GoToEditPictureToNewUserState) {
          return EditPictureToNewUserDisplay(
            profile: state.profile,
          );
        }

        if (state is GoToViewProfileSubUserDisplayState) {
          return ViewProfileSubUserDisplay(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is LoadingEditUsersState) {
          if (profile.parameters.location == 'ProfilePictureSubUser') {
            return AddPictureToNewUserDisplay(
              profile: state.profile,
              loading :state.loading
            );
          }
          if (profile.parameters.location == 'EditProfilePicture') {
            return EditPictureToNewUserDisplay(
              profile: state.profile,
            loading:state.loading
            );
          } else {
            return EditProfileSubUserDisplay(
              profile: state.profile,
              index: state.index,
              loading:state.loading
            );
          }
        }
        if (state is LoadingUsersState) {
          return LoadingWidget();
        }

        return LoadingWidget();
      },
    );
  }
}
