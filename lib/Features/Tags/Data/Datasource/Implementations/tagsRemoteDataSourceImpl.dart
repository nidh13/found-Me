import 'dart:async';
import 'dart:convert';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Tags/Data/Datasource/tagsRemoteDatasource.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';

class TagsRemoteDataSourceImpl implements TagsRemoteDataSource {
  final http.Client client;

  TagsRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> addEditObjectTag(AddEditTagParams addEditTagParams) async {
    Profile profile = addEditTagParams.profile;

    String idUser = profile.userGeneralInfo.idUser;
    String idSession = profile.userGeneralInfo.idSession;
    print(idUser);
    int index = addEditTagParams.index;
    int indexu = addEditTagParams.indexu;
    // int index = profile.parameters.tagsIndex;
    String type = addEditTagParams.type;
    Tags objectTags;
    String serial;
    if (profile.parameters.location == 'Cancel') {
      Profile profilee;

      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=${idUser}",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
      );
      if (viewResponse.statusCode == 200) {
        final tagsListResponse = await http.get(
          "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': 'test',
          },
        );

        if (tagsListResponse.statusCode == 200) {
          profile.userGeneralInfo.tagsList =
              TagsList.fromJson(json.decode(tagsListResponse.body));
        }
        TagsList tagsList = profile.userGeneralInfo.tagsList;
        Notifications notifications = profile.userGeneralInfo.notificationlist;
        RemindersList reminders = profile.userGeneralInfo.remindersList;
        profilee = Profile.fromJson(json.decode(viewResponse.body));
        profilee.parameters = profile.parameters;
        List<Profile> subUsers = [];
        profile = profilee;
        profile.userGeneralInfo.tagsList = tagsList;
        profile.userGeneralInfo.notificationlist = notifications;
        profile.userGeneralInfo.remindersList = reminders;
        profile.userGeneralInfo.idUser = idUser;

        profile.userGeneralInfo.message = 'Success';

        return profile;
      } else if (viewResponse.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    } else {
      if (type == 'object') {
        objectTags =
            profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index];
        serial = profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
            .tagInfo.serialNumber;
      } else if (type == 'medical') {
        objectTags =
            profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index];
        serial = profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
            .tagInfo.serialNumber;
      }

      String sn = profile.userGeneralInfo.sn;
      final response = await http.post(
        "https://foundme-dev.hotline.direct/create_edit_object_tag?id_user=$idUser&sn=$sn",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(objectTags),
      );
      var body = json.encode(objectTags);
      print(body);
      if (response.statusCode == 200 || response.statusCode == 202) {
        final tagsListResponse = await http.get(
          "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': 'test',
          },
        );

        if (tagsListResponse.statusCode == 200) {
          profile.userGeneralInfo.tagsList =
              TagsList.fromJson(json.decode(tagsListResponse.body));
        }
        profile.userGeneralInfo.message = null;
        profile.parameters.serial = serial;
        return profile;
      } else if (response.statusCode != 201 && response.statusCode != 202) {
        profile.userGeneralInfo.message = 'An error occured while updating !';
        return profile;
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Profile> filterTags(Profile profil) async {
    Profile profile = profil;

    String idUser = profil.userGeneralInfo.idUser;
    String idMember = profil.userGeneralInfo.idMember;
    String idSession = profil.userGeneralInfo.idSession;

    // int index = profile.parameters.tagsIndex;
    ObjectTag objectTag;

    int filterType = profil.parameters.filterType;
    String filterDesSN = profil.parameters.filterDescriptionSn;
    String filterIdMember = profil.parameters.filterIdMembre;
    final response = await http.get(
      "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser&filter_type=$filterType&filter_id_membre=$filterIdMember&filter_description_sn=$filterDesSN",
      headers: {
        'Content-Type': 'application/json',
        'idSession': 'test',
      },
    );

    if (response.statusCode == 200) {
      profile.userGeneralInfo.tagsList =
          TagsList.fromJson(json.decode(response.body));
      profile.parameters.filterDescriptionSn = null;
      profile.parameters.filterIdMembre = null;
      profile.parameters.filterType = 0;
      return profile;
    } else if (response.statusCode != 201 || response.statusCode == 202) {
      profile.userGeneralInfo.message = 'Error';
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Profile> verifyTag(Profile profile) async {
    final String serial = profile.parameters.serial;
    final String idMember = profile.userGeneralInfo.idMember;
    final String idUser = profile.userGeneralInfo.idUser;
    int indexu;
    int index;
    List<UserEmergencyContact> listEmergency = [];

    List<UserEmergencyContact> listEmergencyContact() {
      profile.userGeneralInfo.userEmergencyContact.forEach((element) {
        listEmergency.add(element);
      });
    }

    listEmergencyContact();
    final response = await http.get(
      "https://foundme-dev.hotline.direct/scan_tag?serial_number=$serial&id_user=$idUser&id_member=$idMember",
      headers: {
        'Content-Type': 'application/json',
        'idSession': 'test',
      },
    );

    if (json.decode(response.body)["error"] == false) {
      var a = json.decode(response.body);
      profile.parameters.statuscheck = json.decode(response.body)["error"];
      profile.userGeneralInfo.newTags =
          NewTags.fromJson(json.decode(response.body));
      final tagsListResponse = await http.get(
        "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': 'test',
        },
      );

      if (tagsListResponse.statusCode == 200) {
        profile.userGeneralInfo.tagsList =
            TagsList.fromJson(json.decode(tagsListResponse.body));
      }
      if (profile.userGeneralInfo.switchTag == 'yes') {
        profile.parameters.location = 'switch';

        indexu = profile.parameters.indexu;
        index = profile.parameters.indext;
        if (json.decode(response.body)["master"] == 1) {
          profile.userGeneralInfo.message = 'Can not Switch Master Code';
        } else if (profile.parameters.typecheck == 'Pets') {
          if (profile
                  .userGeneralInfo.newTags.newTag.last.tagInfo.idTagCategorie ==
              3) {
            // if (profile.parameters.typecheck == 'medical') {
            //   profile.userGeneralInfo.message = 'You should use medical tag';
            // } else if (profile.parameters.typecheck == 'object') {
            // } else {
            profile.userGeneralInfo.sn = profile.userGeneralInfo.tagsList
                .objectTag[indexu].tags[index].tagInfo.serialNumber;
            profile.userGeneralInfo.petsInfos[indexu].petTag[index].tagInfo
                .serialNumber = serial;
            profile.parameters.location = 'AddPet';
            // }
          } else {
            profile.userGeneralInfo.message = 'You should use pet tag';
          }
        } else {
          if (profile.parameters.typecheck == 'object') {
            profile.parameters.location = '';
            if (profile.userGeneralInfo.newTags.newTag.last.tagInfo.emergency ==
                    0 &&
                profile.userGeneralInfo.newTags.newTag.last.tagInfo
                        .idTagCategorie !=
                    3) {
              profile.userGeneralInfo.sn = profile.userGeneralInfo.tagsList
                  .objectTag[indexu].tags[index].tagInfo.serialNumber;
              profile.userGeneralInfo.tagsList.objectTag[indexu].tags[index]
                  .tagInfo.serialNumber = serial;
            } else {
              profile.userGeneralInfo.message = 'You should use object Tag';
            }
          } else if ((profile.parameters.typecheck == 'medical')) {
            profile.parameters.location = '';

            if (profile.userGeneralInfo.newTags.newTag.last.tagInfo.emergency ==
                1) {
              profile.userGeneralInfo.sn = profile.userGeneralInfo.tagsList
                  .medicalTag[indexu].tags[index].tagInfo.serialNumber;
              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags[index]
                  .tagInfo.serialNumber = serial;
            } else {
              profile.userGeneralInfo.message = 'You should use Medical tag';
            }
          }
        }
      } else if (profile.userGeneralInfo.duplicate == 'yes') {
        indexu = profile.parameters.indexu;
        index = profile.parameters.indext;
        if (json.decode(response.body)["master"] == 1) {
          profile.userGeneralInfo.message = 'Can not duplicate Master Code';
        } else if (profile
                .userGeneralInfo.newTags.newTag.last.tagInfo.idTagCategorie ==
            3) {
          profile.userGeneralInfo.message = 'Can not duplicate code Pet';
        } else {
          if (profile.parameters.typecheck == 'object') {
            if (profile.userGeneralInfo.newTags.newTag.last.tagInfo.emergency ==
                0) {
              profile.userGeneralInfo.tagsList.objectTag[indexu].tags.last =
                  Tags(
                currency: profile.userGeneralInfo.tagsList.objectTag[indexu]
                    .tags[index].currency,
                otherInfo: profile.userGeneralInfo.tagsList.objectTag[indexu]
                    .tags[index].otherInfo,
                preferenceUser: profile.userGeneralInfo.tagsList
                    .objectTag[indexu].tags[index].preferenceUser,
                emergencyContactUser: profile.userGeneralInfo.tagsList
                    .objectTag[indexu].tags[index].emergencyContactUser,
                tagUserInfo: TagUserInfo(
                  idUser: profile.userGeneralInfo.tagsList.objectTag[indexu]
                      .tags[index].tagUserInfo.idUser,
                  firstName: profile.userGeneralInfo.tagsList.objectTag[indexu]
                      .tags[index].tagUserInfo.firstName,
                  lastName: profile.userGeneralInfo.tagsList.objectTag[indexu]
                      .tags[index].tagUserInfo.lastName,
                  mail: profile.userGeneralInfo.tagsList.objectTag[indexu]
                      .tags[index].tagUserInfo.mail,
                  mobile: profile.userGeneralInfo.tagsList.objectTag[indexu]
                      .tags[index].tagUserInfo.mobile,
                  codePhone: profile.userGeneralInfo.tagsList.objectTag[indexu]
                      .tags[index].tagUserInfo.codePhone,
                ),
                tagInfo: profile.userGeneralInfo.tagsList.objectTag[indexu]
                    .tags[index].tagInfo,
              );

              profile.userGeneralInfo.tagsList.objectTag[indexu].tags.last
                  .tagInfo.serialNumber = serial;
              profile.userGeneralInfo.tagsList.objectTag[indexu].tags.last
                      .tagInfo.idTag =
                  profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag;

              profile.userGeneralInfo.tagsList.objectTag[indexu].tags.last
                      .tagInfo.idTagCategorie =
                  profile.userGeneralInfo.newTags.tagCategorie;
              // indexu = profile.userGeneralInfo.tagsList.objectTag.indexWhere(
              //     (element) =>
              //         element.idMember == profile.userGeneralInfo.idMember);
              print(indexu);
              profile.parameters.typecheck = "object";
              profile.parameters.indexu = indexu;
              profile.parameters.indext = profile
                      .userGeneralInfo.tagsList.objectTag[indexu].tags.length -
                  1;
            } else {
              profile.userGeneralInfo.message = 'You should use object Tag';
            }
          } else if ((profile.parameters.typecheck == 'medical')) {
            if (profile.userGeneralInfo.newTags.newTag.last.tagInfo.emergency ==
                1) {
              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags.last =
                  Tags(
                currency: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                    .tags[index].currency,
                otherInfo: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                    .tags[index].otherInfo,
                preferenceUser: profile.userGeneralInfo.tagsList
                    .medicalTag[indexu].tags[index].preferenceUser,
                emergencyContactUser: profile.userGeneralInfo.tagsList
                    .medicalTag[indexu].tags[index].emergencyContactUser,
                tagUserInfo: TagUserInfo(
                  idUser: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                      .tags[index].tagUserInfo.idUser,
                  firstName: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                      .tags[index].tagUserInfo.firstName,
                  lastName: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                      .tags[index].tagUserInfo.lastName,
                  mail: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                      .tags[index].tagUserInfo.mail,
                  mobile: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                      .tags[index].tagUserInfo.mobile,
                  codePhone: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                      .tags[index].tagUserInfo.codePhone,
                ),
                tagInfo: profile.userGeneralInfo.tagsList.medicalTag[indexu]
                    .tags[index].tagInfo,
              );

              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags.last
                  .tagInfo.serialNumber = serial;
              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags.last
                      .tagInfo.idTag =
                  profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag;

              profile.userGeneralInfo.tagsList.medicalTag[indexu].tags.last
                      .tagInfo.idTagCategorie =
                  profile.userGeneralInfo.newTags.tagCategorie;
              // indexu = profile.userGeneralInfo.tagsList.medicalTag.indexWhere(
              //     (element) =>
              //         element.idMember == profile.userGeneralInfo.idMember);
              // print(indexu);
              profile.parameters.typecheck = "medical";
              profile.parameters.indexu = indexu;
              profile.parameters.indext = profile
                      .userGeneralInfo.tagsList.medicalTag[indexu].tags.length -
                  1;
            } else {
              profile.userGeneralInfo.message = 'You should use Medical tag';
            }
          }
        }
      } else {
        Tags objectTag = Tags(
          currency: profile.userGeneralInfo.currency,
          otherInfo: profile.userGeneralInfo.newTags.newTag.last.otherInfo,
          preferenceUser: profile.userGeneralInfo.preferenceUser,
          emergencyContactUser: profile.userGeneralInfo.userEmergencyContact,
          tagUserInfo: TagUserInfo(
            idUser: profile.userGeneralInfo.idUser,
            firstName: profile.userGeneralInfo.firstName,
            lastName: profile.userGeneralInfo.lastName,
            mail: profile.userGeneralInfo.mail,
            mobile: profile.userGeneralInfo.mobile,
            codePhone: profile.userGeneralInfo.codePhone,
          ),
          tagInfo: TagInfo(
            idTag: profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag,
            serialNumber: profile
                .userGeneralInfo.newTags.newTag.last.tagInfo.serialNumber,
            idTagCategorie: profile.userGeneralInfo.newTags.tagCategorie,
            active: 1,
            archive: 0,
            idMember: profile.userGeneralInfo.idMember,
          ),
        );

        if (profile
                .userGeneralInfo.newTags.newTag.last.tagInfo.idTagCategorie ==
            3) {
          if (profile.userGeneralInfo.tagsList.objectTag.length == 0) {
            final tagsListResponse = await http.get(
              "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
              headers: {
                'Content-Type': 'application/json',
                'idSession': 'test',
              },
            );

            if (tagsListResponse.statusCode == 200) {
              profile.userGeneralInfo.tagsList =
                  TagsList.fromJson(json.decode(tagsListResponse.body));
            }
          }
          if (profile.userGeneralInfo.petsInfos.length == 0) {
            PetsInfos petInfo = PetsInfos(
                memberInfo: MemberInfo(
                    firstName: profile.userGeneralInfo.firstName,
                    lastName: profile.userGeneralInfo.lastName,
                    mail: profile.userGeneralInfo.mail,
                    mail2: profile.userGeneralInfo.mail2,
                    mobile: profile.userGeneralInfo.mobile,
                    codePhone: profile.userGeneralInfo.codePhone),
                petTag: List<PetTag>(),
                preferencePet: PreferenceUser(
                  allowLiveChat: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .allowLiveChat.accesLabelTxt,
                      value: '1'),
                  allowShareEmails: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .allowShareEmails.accesLabelTxt,
                      value: '1'),
                  allowShareName: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .allowShareName.accesLabelTxt,
                      value: '1'),
                  allowSharePhone: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .allowSharePhone.accesLabelTxt,
                      value: '1'),
                  allowSharePicture: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .allowSharePicture.accesLabelTxt,
                      value: '1'),
                  includeMail1: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .includeMail1.accesLabelTxt,
                      value: '1'),
                  includeMail2: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .includeMail2.accesLabelTxt,
                      value: profile
                          .userGeneralInfo.preferenceUser.includeMail2.value),
                  includeMobile: Allow(
                      accesLabelTxt: profile.userGeneralInfo.preferenceUser
                          .includeMobile.accesLabelTxt,
                      value: '1'),
                ),
                emergencyContact: listEmergency,
                generalInfo: GeneralInfo(
                    delete: 0,
                    active: 1,
                    birthInfo:
                        BirthDateInfo(day: '01', month: '01', year: 2020),
                    picturePet:
                        'https://s3.amazonaws.com/vetterpc-images/pet_placeholderimage.jpg',
                    idPet: null,
                    idPicture: null,
                    dateBirth: "Fri, 29 Jan 2018 00:00:00 GMT",
                    heightweight: Heightweight(),
                    microscopic: Microscopic()),
                otherInfo: List<OtherInfo>(),
                vaccins: List<Vaccins>());
            profile.userGeneralInfo.petsInfos.add(petInfo);
            profile.parameters.location = 'AddPet';
            profile.parameters.indexu =
                profile.userGeneralInfo.petsInfos.length - 1;
            PetTag petTag = PetTag(
              otherInfo: List<OtherInfo>(),
              preferenceUser:
                  profile.userGeneralInfo.petsInfos.last.preferencePet,
              emergencyContactUser:
                  profile.userGeneralInfo.petsInfos.last.emergencyContact,
              tagUserInfo: TagUserInfo(
                idUser: profile.userGeneralInfo.petsInfos.last.generalInfo.idPet
                    .toString(),
                firstName:
                    profile.userGeneralInfo.petsInfos.last.generalInfo.name,
              ),
              tagInfo: TagInfo(
                  idType: null,
                  idTag:
                      profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag,
                  serialNumber: serial,
                  idTagCategorie: 3,
                  active: 1,
                  archive: 0,
                  emergency: 0,
                  idMember: profile
                      .userGeneralInfo.newTags.newTag.last.tagInfo.idMember),
            );
            profile.userGeneralInfo.petsInfos.last.petTag.add(petTag);
            indexu = 0;
            print(indexu);
            profile.parameters.typecheck = "pet";
            profile.parameters.indexu = indexu;
            // profile.parameters.indext =
            //     profile.userGeneralInfo.tagsList.objectTag[indexu].tags.length;

            // dispatchGoToAddNewUser(profile);
          } else if (profile.userGeneralInfo.petsInfos.length == 1) {
            PetTag petTag = PetTag(
              otherInfo: List<OtherInfo>(),
              preferenceUser:
                  profile.userGeneralInfo.petsInfos[0].preferencePet,
              emergencyContactUser:
                  profile.userGeneralInfo.petsInfos[0].emergencyContact,
              tagUserInfo: TagUserInfo(
                idUser: profile.userGeneralInfo.petsInfos[0].generalInfo.idPet
                    .toString(),
                firstName:
                    profile.userGeneralInfo.petsInfos[0].generalInfo.name,
              ),
              tagInfo: TagInfo(
                  idType: null,
                  idTag:
                      profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag,
                  serialNumber: serial,
                  idTagCategorie: 3,
                  active: 1,
                  archive: 0,
                  emergency: 0,
                  idMember: profile
                      .userGeneralInfo.newTags.newTag.last.tagInfo.idMember),
            );
            profile.userGeneralInfo.petsInfos[0].petTag.add(petTag);
            indexu = 0;
            print(indexu);
            profile.parameters.location = 'AddPet';

            profile.parameters.typecheck = "pet";
            profile.parameters.indexu = indexu;

            //profile.parameters.indext =
            //     profile.userGeneralInfo.tagsList.objectTag[indexu].tags.length;

            // profile.userGeneralInfo.tagsList.objectTag[indexu].tags
            //     .add(objectTag);
          } else if (profile.userGeneralInfo.petsInfos.length > 1) {
            profile.userGeneralInfo.message = 'shoose pet';
            PetTag petTag = PetTag(
              otherInfo: List<OtherInfo>(),
              preferenceUser:
                  profile.userGeneralInfo.petsInfos[0].preferencePet,
              emergencyContactUser:
                  profile.userGeneralInfo.petsInfos[0].emergencyContact,
              tagUserInfo: TagUserInfo(
                idUser: profile.userGeneralInfo.petsInfos[0].generalInfo.idPet
                    .toString(),
                firstName:
                    profile.userGeneralInfo.petsInfos[0].generalInfo.name,
              ),
              tagInfo: TagInfo(
                  idType: null,
                  idTag:
                      profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag,
                  serialNumber: serial,
                  idTagCategorie: 3,
                  active: 1,
                  archive: 0,
                  emergency: 0,
                  idMember: profile
                      .userGeneralInfo.newTags.newTag.last.tagInfo.idMember),
            );
            profile.userGeneralInfo.petsInfos[0].petTag.add(petTag);
            indexu = 0;
            print(indexu);
            profile.parameters.location = 'AddPet';

            profile.parameters.typecheck = "pet";
            profile.parameters.indexu = indexu;
            // profile.parameters.indext =
            //     profile.userGeneralInfo.tagsList.objectTag[indexu].tags.length;

            //  profile.userGeneralInfo.tagsList.objectTag[indexu].tags
            //     .add(objectTag);
            // final tagsListResponse = await http.get(
            //   "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
            //   headers: {
            //     'Content-Type': 'application/json',
            //     'idSession': 'test',
            //   },
            // );

            // if (tagsListResponse.statusCode == 200) {
            //   profile.userGeneralInfo.tagsList =
            //       TagsList.fromJson(json.decode(tagsListResponse.body));
            // }
          }
        } else {
          //    print(profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag);

          if (profile.userGeneralInfo.newTags.newTag.last.tagInfo.emergency ==
              0) {
            if (profile.userGeneralInfo.tagsList.objectTag.length == 0) {
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
            }
            if (json.decode(response.body)["master_tag"] == null &&
                json.decode(response.body)["master"] == 0) {
              // final tagsListResponse = await http.get(
              //   "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
              //   headers: {
              //     'Content-Type': 'application/json',
              //     'idSession': 'test',
              //   },
              // );

              // if (tagsListResponse.statusCode == 200) {
              //   profile.userGeneralInfo.tagsList =
              //       TagsList.fromJson(json.decode(tagsListResponse.body));
              // }
              // profile.userGeneralInfo.tagsList.objectTag[indexu].tags.last
              //     .tagInfo.serialNumber = serial;

              indexu = profile.userGeneralInfo.tagsList.objectTag.indexWhere(
                  (element) =>
                      element.idMember == profile.userGeneralInfo.idMember);
              print(indexu);
              profile.parameters.typecheck = "object";
              profile.parameters.indexu = indexu;
              profile.parameters.indext = profile
                      .userGeneralInfo.tagsList.objectTag[indexu].tags.length -
                  1;

              // profile.userGeneralInfo.tagsList.objectTag[indexu].tags
              //     .add(objectTag);
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
              //traitement
            } else if (json.decode(response.body)["master_tag"] != null &&
                json.decode(response.body)["master"] == 0) {
              //Traitement
              if (json.decode(response.body)["op"] != 'update') {
                profile.userGeneralInfo.message =
                    'You wont to activate your master code and all the codes associated with it ?';

                indexu = profile.userGeneralInfo.tagsList.objectTag.indexWhere(
                    (element) =>
                        element.idMember == profile.userGeneralInfo.idMember);
                print(indexu);
                profile.parameters.typecheck = "object";
                profile.parameters.indexu = indexu;
                profile.parameters.indext = profile.userGeneralInfo.tagsList
                        .objectTag[indexu].tags.length -
                    1;

                // profile.userGeneralInfo.tagsList.objectTag[indexu].tags
                //     .add(objectTag);
                profile.userGeneralInfo.masterTag =
                    json.decode(response.body)["master_tag"];
              }
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
              print(profile.userGeneralInfo.message);
            } else if (json.decode(response.body)["master"] == 1) {
              // if (json.decode(response.body)["op"] == 'update') {
              //   profile.userGeneralInfo.message = 'Master code already active !';
              // } else {
              profile.userGeneralInfo.masterTag =
                  json.decode(response.body)["master_tag"];

              profile.userGeneralInfo.message = 'MasterTag';
              // }
              print(profile.userGeneralInfo.message);
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
            }
          } else if (profile
                  .userGeneralInfo.newTags.newTag.last.tagInfo.emergency ==
              1) {
            if (json.decode(response.body)["master_tag"] == null &&
                json.decode(response.body)["master"] == 0) {
              indexu = profile.userGeneralInfo.tagsList.medicalTag.indexWhere(
                  (element) =>
                      element.idMember == profile.userGeneralInfo.idMember);
              profile.parameters.typecheck = "medical";
              profile.parameters.indexu = indexu;
              profile.parameters.indext = profile
                      .userGeneralInfo.tagsList.medicalTag[indexu].tags.length -
                  1;
              // profile.userGeneralInfo.tagsList.medicalTag.last.tags
              //     .add(objectTag);
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
            } else if (json.decode(response.body)["master_tag"] != null &&
                json.decode(response.body)["master"] == 0) {
              if (json.decode(response.body)["op"] != 'update') {
                profile.userGeneralInfo.message =
                    'You wont to activate your master code and all the codes associated with it ?';
              }

              indexu = profile.userGeneralInfo.tagsList.medicalTag.indexWhere(
                  (element) =>
                      element.idMember == profile.userGeneralInfo.idMember);
              profile.parameters.typecheck = "medical";
              profile.parameters.indexu = indexu;
              profile.parameters.indext = profile
                      .userGeneralInfo.tagsList.medicalTag[indexu].tags.length -
                  1;
              // profile.userGeneralInfo.tagsList.medicalTag.last.tags
              //     .add(objectTag);
              profile.userGeneralInfo.masterTag =
                  json.decode(response.body)["master_tag"];
              print(profile.userGeneralInfo.message);
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
            } else if (json.decode(response.body)["master"] == 1) {
              // if (json.decode(response.body)["op"] == 'update') {
              //   profile.userGeneralInfo.message =
              //       'Master code already activite !';
              // } else {
              profile.userGeneralInfo.masterTag =
                  json.decode(response.body)["master_tag"];
              profile.userGeneralInfo.message = 'MasterTag';
              // }
              print(profile.userGeneralInfo.message);
              final tagsListResponse = await http.get(
                "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
                headers: {
                  'Content-Type': 'application/json',
                  'idSession': 'test',
                },
              );

              if (tagsListResponse.statusCode == 200) {
                profile.userGeneralInfo.tagsList =
                    TagsList.fromJson(json.decode(tagsListResponse.body));
              }
            }
          }
        }
      }
      return profile;
    } else if (json.decode(response.body)["error"] == true) {
      //  profile.parameters.result.add({"error": "error"});
      if (profile.userGeneralInfo.switchTag == 'yes') {
        profile.parameters.location = 'switch';
      }
      profile.userGeneralInfo.message = json.decode(response.body)["message"];
      print(profile.userGeneralInfo.message);
      return profile;
    } else if (response.statusCode == 500) {
      if (profile.userGeneralInfo.switchTag == 'yes') {
        profile.parameters.location = 'switch';
      }
      profile.userGeneralInfo.message =
          'Server failure it will be up in a minute';
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  Future<Profile> listTags(Profile profile) async {
    String idUser = profile.userGeneralInfo.idUser;
    String idSession = profile.userGeneralInfo.idSession;

    final tagsListResponse = await http.get(
      "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
    );
    print(tagsListResponse.body);
    if (tagsListResponse.statusCode == 200) {
      profile.userGeneralInfo.tagsList =
          TagsList.fromJson(json.decode(tagsListResponse.body));
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Profile> uploadFile(
      AddEditObjectTagParams addEditObjectTagParams) async {
    Profile profile = addEditObjectTagParams.profile;
    String idUser = profile.userGeneralInfo.idUser;
    String idSession = 'test'; // profile.userGeneralInfo.idSession;

    int index = addEditObjectTagParams.index;
    int indexx = addEditObjectTagParams.indexu;
    String type;
    var stream = new http.ByteStream(profile.parameters.file.openRead());
    stream.cast();
    var length = await profile.parameters.file.length();
    var request = new http.MultipartRequest(
      "POST",
      Uri.parse(
        'https://ws.interface-crm.com:444/upload_document?id_user=$idUser',
      ),
    );
    var multipartFile = new http.MultipartFile(
      'file',
      stream,
      length,
      filename: basename(
        profile.parameters.file.path,
      ),
    );
    request.headers.addAll(
      {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
    );
    request.files.add(multipartFile);
    var response = await request.send();
    response.stream
        .transform(utf8.decoder)
        .listen((event) async {
          print(event);
          var value = await jsonDecode(event);

          if (value['error'] == false) {
            profile.parameters.fileUrl = value['url'];
          }
        })
        .asFuture()
        .then((value) {
          if (profile.parameters.location == 'ObjectTagPicture') {
            profile.userGeneralInfo.tagsList.objectTag[indexx].tags[index]
                .tagInfo.pictureUrl = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'MedicalTagPicture') {
            profile.userGeneralInfo.tagsList.medicalTag[indexx].tags[index]
                .tagInfo.pictureUrl = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'otherMedicalRecordInfo') {
            profile
                .userGeneralInfo
                .tagsList
                .objectTag[index]
                .tags[indexx]
                .otherInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'MedicalRecordInfo') {
            profile
                .userGeneralInfo
                .tagsList
                .medicalTag[index]
                .tags[indexx]
                .otherInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }

          print('Completeeeeeeed');
          return profile;
        });
    return profile;
  }
}
