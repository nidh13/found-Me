import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/editProfileDisplay.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/viewProfileDisplay.dart';
import 'package:neopolis/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class ProfilePage extends StatelessWidget {
  final Profile profile;

  const ProfilePage({
    Key key,
    @required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is EmptyProfileState) {
          if (profile.parameters.location == "View profile") {
            BlocProvider.of<ProfileBloc>(context).dispatch(
              EditProfileEvent(
                profile: profile,
              ),
            );
          }
          if (profile.parameters.location == 'Edit profile') {
            BlocProvider.of<ProfileBloc>(context).dispatch(
              EditProfileEvent(
                profile: profile,
              ),
            );
          }
          if (profile.parameters.location == "View profile sucess") {
            BlocProvider.of<ProfileBloc>(context).dispatch(
              GoToViewProfileEvent(
                profile: profile,
              ),
            );
          } else if (profile.parameters.location == "profile") {
            BlocProvider.of<ProfileBloc>(context).dispatch(
              GoToEditProfileEvent(
                profile: profile,
              ),
            );
          } else if (profile.parameters.location == "Edit view profile") {
            BlocProvider.of<ProfileBloc>(context).dispatch(
              EditProfileEvent(
                profile: profile,
              ),
            );
          } else if (profile.parameters.location == "view home") {
            BlocProvider.of<ProfileBloc>(context).dispatch(
              EditProfileEvent(
                profile: profile,
              ),
            );
          }
        }

        if (state is GoToViewProfileState) {
          return ViewProfileDisplay(
            profile: state.profile,
          );
        }
        if (state is GoToHomeState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is GoToEditProfileState) {
          return EditProfileDisplay(
            profile: state.profile,
          );
        }

        if (state is ErrorProfileState) {
          return EditProfileDisplay(
            profile: state.profile,
           
          );
        }

        // if (state is EditProfileState) {
        //   return EditProfileDisplay(
        //     // ListOfEyeMap is missing !!
        //     profile: state.profile,
        //     message: state.message,
        //   );
        // }

        if (state is LoadingProfileFileState) {
          return EditProfileDisplay(
            profile: state.profile,
             loading: state.loading,
          );
        }

        if (state is LoadingProfileState) {
          return LoadingWidget();
        }

        return LoadingWidget();
      },
    );
  }
}
