import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/uploadFilePets.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/editProfilePets.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/addTagPets.dart';

part 'pets_event.dart';
part 'pets_state.dart';

class PetsBloc extends Bloc<PetsEvent, PetsState> {
  final UploadFilePets uploadFilePets;
  final EditProfilePets editProfilePets;
  final AddPetTags addTagPets;
  PetsBloc({
    @required this.uploadFilePets,
    @required this.editProfilePets,
    @required this.addTagPets,
  });

  @override
  PetsState get initialState => EmptyPetsState();

  @override
  Stream<PetsState> mapEventToState(
    PetsEvent event,
  ) async* {
    if (event is GoToViewProfilePetEvent) {
      yield GoToViewProfilePetsState(
          profile: event.profile, index: event.index);
    }

    if (event is GoToEditProfilePetDisplayEvent) {
      yield GoToEditProfilePetsState(
        profile: event.profile,
        index: event.index,
      );
    }
    if (event is GoToSerialNumberToPetTagEvent) {
      yield GoToSerialNumberToPetTagState(
          profile: event.profile, index: event.index);
    }
    if (event is GoToEditProfilePetEvent) {
      yield LoadingPetsState();
      AddEditUploadFilePetsParams addEditPetsParams =
          AddEditUploadFilePetsParams(
        profile: event.profile,
        index: event.index,
      );
      final failureOrToken = await editProfilePets(addEditPetsParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield EmptyPetsState();
        },
        (profile) async* {
          if (profile.userGeneralInfo.message == "Error") {
            yield ErrorPetsState(
              profile: profile,
            );
          } else if (profile.parameters.location!='deletePet') {
            if (profile.parameters.location == 'View Pet') {
              profile.parameters.location = '';
              yield GoToViewProfilePetsState(
                  profile: profile, index: event.index);
            } else if (profile.parameters.location == 'View save pet') {
              profile.parameters.location = '';
              yield GoToViewProfilePetsState(
                profile: profile,
                index: event.index,
              );
            } else {
              yield GoToEditProfilePetsState(
                profile: profile,
                index: event.index,
              );
            }
          } else if (profile.parameters.location=='deletePet') {
          //  profile.userGeneralInfo.petsInfos.removeAt(event.index);
            yield GoToHomeScreenState(profile: profile);
          }
        },
      );
    }
    if (event is UploadFilePetEvent) {
      yield LoadingPetsFileState(
        profile: event.profile,
        index: event.index,
        loading:'true',
      );
      AddEditUploadFilePetsParams addEditUploadFilePetsParams =
          AddEditUploadFilePetsParams(
        profile: event.profile,
        index: event.index,
      );
      final failureOrToken = await uploadFilePets(addEditUploadFilePetsParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorPetsState(
            profile: event.profile,
          );
        },
        (profile) async* {
          yield GoToEditProfilePetsState(profile: profile, index: event.index);
        },
      );
    }
    if (event is AddTagPetsEvent) {
      yield LoadingPetsState();
      AddEditUploadFilePetsParams addEditUploadFilePetsParams =
          AddEditUploadFilePetsParams(
        profile: event.profile,
        index: event.index,
      );
      final failureOrToken = await addTagPets(addEditUploadFilePetsParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorPetsState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message != null &&
              profile.userGeneralInfo.message != '') {
            yield GoToSerialNumberToPetTagState(
                profile: profile, index: event.index);
          } else {
            yield GoToEditProfilePetsState(
                profile: profile, index: event.index);
          }
        },
      );
    }
  }
}
