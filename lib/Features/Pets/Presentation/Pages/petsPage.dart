import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/loadingWidget.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/editPetProfileDisplay.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/viewPetProfileDisplay.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/serialNumberToPetTagDisplay.dart';

class PetsPage extends StatelessWidget {
  final Profile profile;
  final int index;
  final String route;
  const PetsPage(
      {Key key,
      @required this.profile,
      @required this.index,
      @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetsBloc, PetsState>(
      builder: (context, state) {
        if (state is EmptyPetsState) {
          if (route == 'GoToViewPetProfile') {
            if (profile.parameters.location == 'View Pet') {
              BlocProvider.of<PetsBloc>(context).dispatch(
                GoToEditProfilePetEvent(
                  profile: profile,
                  index: index,
                ),
              );
            } else {
              BlocProvider.of<PetsBloc>(context).dispatch(
                GoToViewProfilePetEvent(
                  profile: profile,
                  index: index,
                ),
              );
            }
          }
          if (route == 'GoToAddEditPetProfile') {
            if (profile.parameters.location == 'View save pet') {
              BlocProvider.of<PetsBloc>(context).dispatch(
                GoToEditProfilePetEvent(
                  profile: profile,
                  index: index,
                ),
              );
            } else {
              BlocProvider.of<PetsBloc>(context).dispatch(
                GoToEditProfilePetDisplayEvent(
                  profile: profile,
                  index: index,
                ),
              );
            }
          }
          if (route == 'GoToEditPetProfile') {
            BlocProvider.of<PetsBloc>(context).dispatch(
              GoToEditProfilePetDisplayEvent(
                profile: profile,
                index: index,
              ),
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

        if (state is GoToSerialNumberToPetTagState) {
          return SerialNumberToPetTagDisplay(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is GoToEditProfilePetsState) {
          return EditPetProfileDisplay(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is GoToViewProfilePetsState) {
          return ViewProfilePetDisplay(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is AddTagPetsState) {
          AddTagPetsEvent(
            profile: state.profile,
            index: state.index,
          );
        }
        if (state is AddTagPetsState) {
          AddTagPetsEvent(
            profile: state.profile,
            index: state.index,
          );
        }

        if (state is GoToHomeScreenState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/homeProvider',
              arguments: state.profile,
            );
          });
        }

        if (state is LoadingPetsFileState) {
          return EditPetProfileDisplay(
            profile: state.profile,
            index: state.index,
            loading:state.loading
          );
        }

        return LoadingWidget();
      },
    );
  }
}
