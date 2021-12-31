import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/addEditObjectTag.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/listTags.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/verifyTag.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/filterTag.dart';
part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  AddEditObjectTag addEditObjectTag;
  UploadFileObjectTag uploadFileObjectTag;
/*   ListTags listingTags; */
  VerifyTag verifyTag;
  Profile profile;
  FilterTags filterTags;

  TagsBloc({
    @required this.addEditObjectTag,
    @required this.uploadFileObjectTag,
    /*    @required this.listingTags, */
    @required this.verifyTag,
    @required this.filterTags,
  });

  @override
  TagsState get initialState => EmptyObjectTagState();

  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    if (event is GoToSerialNumberToObjectTagEvent) {
      yield GoToSerialNumberToObjectTagState(profile: event.profile);
    }

    if (event is GoToViewObjectTagEvent) {
      yield GoToViewObjectTagState(
        profile: event.profile,
        type: event.type,
        indexu: event.indexu,
        index: event.index,
      );
    }

    if (event is GoToAddEditObjectTagEvent) {
      yield GoToAddEditObjectTagState(
        profile: event.profile,
        type: event.type,
        indexu: event.indexu,
        index: event.index,
      );
    }

    if (event is GoToViewPetsEvent) {
      yield ViewProfilePetState(
        profile: event.profile,
        index: event.index,
      );
    }

    if (event is GoToSwitchObjectTagEvent) {
      yield GoToSwitchObjectTagState(
        profile: event.profile,
      );
    }
    if (event is ListingTagEvent) {
      yield ListingFilterTagState(
        profile: event.profile,
      );
    }
    if (event is GoToListingTagEvent) {
      yield GoToListingTagState(
        profile: event.profile,
      );
    }

    if (event is GoTogetSwitchObjectTagEvent) {
      yield GoTogetSwitchObjectTagState(
        profile: event.profile,
        type: event.type,
        indexu: event.indexu,
        index: event.index,
      );
    }

    if (event is AddEditObjectTagEvent) {
      yield LoadingObjectTagState();
      AddEditTagParams addEditTagParams = AddEditTagParams(
        profile: event.profile,
        type: event.type,
        index: event.index,
        indexu: event.indexu,
      );

      final failureOrToken = await addEditObjectTag(addEditTagParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorObjectTagState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.parameters.location=='DeleteTag'){
yield ListingFilterTagState(profile:event.profile );
          }
          
         else if (profile.parameters.location=='SaveTag'){
  yield GoToViewObjectTagState(
        profile: event.profile,
        type: event.type,
        indexu: event.indexu,
        index: event.index,
      );
          } else  if(profile.parameters.location =='Cancel'){
                        yield GoToViewObjectTagState(
        profile: event.profile,
        type: event.type,
        indexu: event.indexu,
        index: event.index,
      );                   
                                        }
          else
         
          { 
if(event.type=='object'){
 
  int index;
  int indexu;
  for (int i = 0;
              i < profile.userGeneralInfo.tagsList.objectTag.length;
              i++) {
            for (int j = 0;
                j < profile.userGeneralInfo.tagsList.objectTag[i].tags.length;
                j++) {
              if (profile.userGeneralInfo.tagsList.objectTag[i].tags[j].tagInfo
                      .serialNumber ==
                   profile.parameters.serial) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
             yield AddEditObjectTagState(
            profile: event.profile,
            type: event.type,
            indexu: indexu,
            index: index,
          );

}else {
   int index;
  int indexu;
  for (int i = 0;
              i < profile.userGeneralInfo.tagsList.medicalTag.length;
              i++) {
            for (int j = 0;
                j < profile.userGeneralInfo.tagsList.medicalTag[i].tags.length;
                j++) {
              if (profile.userGeneralInfo.tagsList.medicalTag[i].tags[j].tagInfo
                      .serialNumber ==
                   profile.parameters.serial) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
             yield AddEditObjectTagState(
            profile: event.profile,
            type: event.type,
            indexu: indexu,
            index: index,
          );
}
            
          
          }  },
      );
    }
    if (event is FilterListingTagEvent) {
      yield LoadingObjectTagState();

      final failureOrToken = await filterTags(event.profile);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorObjectTagState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.parameters.location == 'switch') {
               if ( (profile.userGeneralInfo.tagsList.medicalTag.length + profile.userGeneralInfo.tagsList.objectTag.length+ profile.userGeneralInfo.tagsList.petTag.length)==1)
            {
              if (profile.userGeneralInfo.tagsList.medicalTag.length!=0){
              if(  profile.userGeneralInfo.tagsList.medicalTag[0].tags.length==1){
                yield GoTogetSwitchObjectTagState(
            profile: event.profile,
            type: 'medical',
            indexu:0,
            index:0,
          );
              }
              
              }
               if (profile.userGeneralInfo.tagsList.objectTag.length!=0){
              if(  profile.userGeneralInfo.tagsList.objectTag[0].tags.length==1){
                yield GoTogetSwitchObjectTagState(
            profile: event.profile,
            type: 'object',
            indexu:0,
            index:0,
          );}}
           if (profile.userGeneralInfo.tagsList.petTag.length!=0){
              if(  profile.userGeneralInfo.tagsList.petTag[0].tags.length==1){
                yield GoTogetSwitchObjectTagState(
            profile: event.profile,
            type: 'pets',
            indexu:0,
            index:0,
          );}}}else {
            yield SwitchFilterTagState(
              profile: event.profile,
            );}
          } else {
            if ( (profile.userGeneralInfo.tagsList.medicalTag.length + profile.userGeneralInfo.tagsList.objectTag.length+ profile.userGeneralInfo.tagsList.petTag.length)==1)
            {
              if (profile.userGeneralInfo.tagsList.medicalTag.length!=0){
              if(  profile.userGeneralInfo.tagsList.medicalTag[0].tags.length==1){
                yield AddEditObjectTagState(
            profile: event.profile,
            type: 'medical',
            indexu:0,
            index:0,
          );
              }
              
              }
               if (profile.userGeneralInfo.tagsList.objectTag.length!=0){
              if(  profile.userGeneralInfo.tagsList.objectTag[0].tags.length==1){
                yield AddEditObjectTagState(
            profile: event.profile,
            type: 'object',
            indexu:0,
            index:0,
          );
              }
              }
               if (profile.userGeneralInfo.tagsList.petTag.length!=0){
              if(  profile.userGeneralInfo.tagsList.petTag[0].tags.length==1){
            
                 int indexpet =profile.userGeneralInfo.petsInfos
                                        .indexWhere((element) =>
                                            element.generalInfo.idPet ==
                                           profile
                                                .userGeneralInfo
                                                .tagsList
                                                .petTag[0]
                                                .tags[0]
                                                .tagInfo
                                                .idPet);
                yield GoToViewPetTagState(profile: profile,index: indexpet);
              }}
            }
            else {
 yield ListingFilterTagState(
              profile: event.profile,
            );
            }
           
          }
        },
      );
    }

/*     if (event is ListingTagEvent) {
      yield LoadingObjectTagState();
      final failureOrToken = await listingTags(event.profile);
      yield* failureOrToken.fold((failure) async* {
        yield ErrorObjectTagState(
          profile: event.profile,
        );
      }, (profile) async* {
        yield ListingTagState(
          profile: event.profile,
        );
      });
    } */

    if (event is UploadFileEvent) {
      yield LoadingObjectTagFileState(
        profile: event.profile,
        type: event.type,
         indexu: event.indexu,
        index: event.index,
        loading: 'true'
      );
      AddEditObjectTagParams addEditObjectTagParams = AddEditObjectTagParams(
          profile: event.profile, indexu: event.indexu, index: event.index);
      final failureOrToken = await uploadFileObjectTag(addEditObjectTagParams);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorTagsState(
            profile: event.profile,
          );
        },
        (profile) async* {
          yield GoToAddEditObjectTagState(
            profile: profile,
            type: event.type,
            indexu: event.indexu,
        index: event.index,
          );
        },
      );
    }

    if (event is VerifyTagEvent) {
      yield LoadingObjectTagState();

      final failureOrToken = await verifyTag(event.profile);
      yield* failureOrToken.fold(
        (failure) async* {
          yield ErrorTagsState(
            profile: event.profile,
          );
        },
        (profile) async* {
          if (profile.userGeneralInfo.message != null) {
            if (profile.parameters.location == 'switch') {
              yield GoTogetSwitchObjectTagState(
                profile: profile,
                type: profile.parameters.typecheck,
                indexu: profile.parameters.indexu,
                index: profile.parameters.indext,
              );
            } else {
              yield GoToSerialNumberToObjectTagState(
                profile: profile,
              );
            }
          } else if (profile.parameters.location == 'AddPet') {
            yield GoToAddEditPetState(
                profile: profile, index: profile.parameters.indexu);
          } else if (profile.parameters.location == 'switch') {
            yield GoTogetSwitchObjectTagState(
              profile: profile,
              type: profile.parameters.typecheck,
              indexu: profile.parameters.indexu,
              index: profile.parameters.indext,
            );
          } else {
             if(profile.userGeneralInfo.duplicate=='yes'){
    profile.userGeneralInfo.duplicate=null;
  }
            yield VerifyTagState(
                profile: profile,
                type: profile.parameters.typecheck,
                indexu: profile.parameters.indexu,
                index: profile.parameters.indext);
          }
        },
      );
    }
  }
}
