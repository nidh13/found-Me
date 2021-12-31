import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/homeDisplay.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/resetpasswordDisplay.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/switchObjectTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/addEditObjectTagDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/listingTagDisplay.dart';

class HomePage extends StatelessWidget {
  final Profile profile;

  const HomePage({Key key, @required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is EmptyHomeState) {
          if (profile.parameters.location == 'Reset Password') {
            return ResetPasswordDisplay(
              profile: profile,
            );
          } else if (profile.parameters.location == 'Log out') {
            BlocProvider.of<HomeBloc>(context).dispatch(
              LogoutEvent(profile: profile),
            );
            //  LogoutEvent(profile: profile);
          } else {
            return HomeDisplay(
              profile: profile,
            );
          }
        }

        if (state is GoToHomeState) {
          return HomeDisplay(
            profile: state.profile,
          );
        }

        if (state is LoadingHomeState) {
          return LoadingWidget();
        }

        if (state is ErrorHomeState) {
          return ResetPasswordDisplay(
            profile: state.profile,
          );
        }

        if (state is GoToEditProfileState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/profileProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is GoToResetPasswordState) {
          return ResetPasswordDisplay(
            profile: state.profile,
          );
        }

        if (state is ResetPasswordState) {
          return ResetPasswordDisplay(
            profile: state.profile,
          );
        }

        // if (state is GoToViewObjectTagState) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Navigator.of(context).pushReplacementNamed(
        //       '/tagsProvider',
        //       arguments: {
        //         'profile': state.profile,
        //         'state': state.toString(),
        //       },
        //     );
        //   });
        // }

        // if (state is GoToEditObjectTagState) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     Navigator.of(context).pushReplacementNamed(
        //       '/tagsProvider',
        //       arguments: {
        //         'profile': state.profile,
        //         'state': state.toString(),
        //       },
        //     );
        //   });
        // }

        if (state is GoToAddEditObjectTagState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/tagsProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is GoToAddEditObjectTagHomeState) {
          return AddEditObjectTagDisplay(
            profile: state.profile,
            index: state.index,
          );
        }

        if (state is GoToSwitchObjectTagState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/tagsProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is GoToListingTagState) {
          return ListingTag(
            profile: state.profile,
            viewtypeTag: state.viewTag,
          );
        }

        if (state is GoToEditProfilePetsState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/petsProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is LogoutState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/signinProvider',
              arguments: true,
            );
          });
        }

        if (state is GoToMessagesState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/messagesProvider',
              arguments: state.profile,
            );
          });
        }

/*
        if (state is GoToViewProfileState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/profileProvider',
              arguments: {
                'profile': state.profile,
                'state': state,
              },
            );
          });
*/

        return LoadingWidget();
      },
    );
  }
}
