import 'dart:async';
import 'dart:convert';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Users/Data/Datasource/usersRemoteDatasource.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Error/exceptions.dart';

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource {
  final http.Client client;
  UsersRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> editProfileSubUser(
      AddEditUsersParams addEditUsersParams) async {
    Profile profile = addEditUsersParams.profile;
    int index = addEditUsersParams.index;
    String idUser = profile.userGeneralInfo.idUser;
    String idsubuser =
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.idSubUser;
    String idLanguage =
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.userIdLanguage;
    print(idsubuser);
    //  String idSession = profile.userGeneralInfo.idSession;
    String idSession = 'test';
    if (profile.parameters.location == 'Save sub user') {
      final response = await http.post(
        "https://foundme-dev.hotline.direct/add_edit_sub_user?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.userGeneralInfo.subUsers[index]),
      );
      print(profile.userGeneralInfo.update);
      var body = json.encode(profile.userGeneralInfo.subUsers[index]);
      print(body);
      var responseUpdate = json.decode(response.body);
      print(responseUpdate);
      if (response.statusCode == 200) {
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.idMember =
            responseUpdate['id_member'];
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.idSubUser =
            responseUpdate['id_sub_user'];
        Profile profilee;

        final viewResponse = await http.get(
          "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': idSession,
          },
        );
        if (viewResponse.statusCode == 200) {
          TagsList tagsList = profile.userGeneralInfo.tagsList;
          Notifications notifications =
              profile.userGeneralInfo.notificationlist;
          RemindersList reminders = profile.userGeneralInfo.remindersList;
          profilee = Profile.fromJson(json.decode(viewResponse.body));
          profilee.parameters = profile.parameters;
          List<Profile> subUsers = [];
          profile = profilee;
          profile.userGeneralInfo.tagsList = tagsList;
          profile.userGeneralInfo.notificationlist = notifications;
          profile.userGeneralInfo.remindersList = reminders;
          profile.userGeneralInfo.idUser = idUser;
          profile.userGeneralInfo.subUsers.forEach((element) {
            if (element.userGeneralInfo.roleLabel == 'Administrator') {
              subUsers.insert(0, element);
            } else {
              subUsers.add(element);
            }
          });
          profile.userGeneralInfo.subUsers = subUsers;
        }
        profile.userGeneralInfo.message = 'Success';
        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    } else if (profile.parameters.location == "view save user") {
      final response = await http.post(
        "https://foundme-dev.hotline.direct/add_edit_sub_user?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.userGeneralInfo.subUsers[index]),
      );
      print(profile.userGeneralInfo.update);
      var body = json.encode(profile.userGeneralInfo.subUsers[index]);
      print(body);
      var responseUpdate = json.decode(response.body);
      print(responseUpdate);
      if (response.statusCode == 200) {
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.idMember =
            responseUpdate['id_member'];
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.idSubUser =
            responseUpdate['id_sub_user'];
        Profile profilee;

        final viewResponse = await http.get(
          "https://foundme-dev.hotline.direct/view_user?id_user=${idUser}",
          headers: {
            'Content-Type': 'application/json',
            'idSession': idSession,
          },
        );
        if (viewResponse.statusCode == 200) {
          TagsList tagsList = profile.userGeneralInfo.tagsList;
          Notifications notifications =
              profile.userGeneralInfo.notificationlist;
          RemindersList reminders = profile.userGeneralInfo.remindersList;
          profilee = Profile.fromJson(json.decode(viewResponse.body));
          profilee.parameters = profile.parameters;
          List<Profile> subUsers = [];
          profile = profilee;
          profile.userGeneralInfo.tagsList = tagsList;
          profile.userGeneralInfo.notificationlist = notifications;
          profile.userGeneralInfo.remindersList = reminders;
          profile.userGeneralInfo.idUser = idUser;
          profile.userGeneralInfo.subUsers.forEach((element) {
            if (element.userGeneralInfo.roleLabel == 'Administrator') {
              subUsers.insert(0, element);
            } else {
              subUsers.add(element);
            }
          });
          profile.userGeneralInfo.subUsers = subUsers;
        }
        profile.userGeneralInfo.message = 'Success';
        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    } else if (profile.parameters.location == 'view sub user') {
      Profile profilee;

      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=${idUser}",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
      );
      if (viewResponse.statusCode == 200) {
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
        profile.userGeneralInfo.subUsers.forEach((element) {
          if (element.userGeneralInfo.roleLabel == 'Administrator') {
            subUsers.insert(0, element);
          } else {
            subUsers.add(element);
          }
        });
        profile.userGeneralInfo.subUsers = subUsers;
        //  profile.userGeneralInfo.subUsers = subUser;
        profile.parameters.location = 'view sub user';
        profile.userGeneralInfo.message = 'Success';

        return profile;
      } else if (viewResponse.statusCode != 202) {
        profilee.parameters.location = "profile";

        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    }
  }

  Future<Profile> deleteProfileSubUser(
      AddEditUsersParams addEditUsersParams) async {
    Profile profile = addEditUsersParams.profile;
    int index = addEditUsersParams.index;
    String idUser = profile.userGeneralInfo.idUser;
    String idsubuser =
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.idSubUser;
    String idLanguage =
        profile.userGeneralInfo.subUsers[index].userGeneralInfo.userIdLanguage;
    print(idsubuser);
    //  String idSession = profile.userGeneralInfo.idSession;
    String idSession = 'test';

    final response = await http.post(
      "https://foundme-dev.hotline.direct/delete_user?id_user=$idUser",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
      body: json.encode(profile.userGeneralInfo.subUsers[index]),
    );
    print(profile.userGeneralInfo.update);
    var body = json.encode(profile.userGeneralInfo.subUsers[index]);
    print(body);

    if (response.statusCode == 200) {
      profile.userGeneralInfo.message = 'Success';

      Parameters parameters = profile.parameters;

      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
      );
      if (viewResponse.statusCode == 200) {
        profile = Profile.fromJson(json.decode(viewResponse.body));
        profile.parameters = parameters;
        profile.userGeneralInfo.idUser = profile.userGeneralInfo.idUser;
        profile.userGeneralInfo.message = 'Success';
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
      return profile;
    } else if (response.statusCode != 202) {
      profile.userGeneralInfo.message = 'Error';
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Profile> uploadFile(
      AddEditUploadFileUsersParams addEditUploadFileUsersParams) async {
    Profile profile = addEditUploadFileUsersParams.profile;
    String idUser = profile.userGeneralInfo.idUser;

    int index = addEditUploadFileUsersParams.index;
    String idSession = 'test'; // profile.userGeneralInfo.idSession;

    profile.parameters.fileUrl = '';

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
    await response.stream
        .transform(utf8.decoder)
        .listen((event) async {
          var value = await jsonDecode(event);

          if (value['error'] == false) {
            profile.parameters.fileUrl = value['url'];
          }
        })
        .asFuture()
        .then((value) {
          print(profile.parameters.fileUrl);

          if (profile.parameters.location == 'ProfilePicture') {
            profile.userGeneralInfo.subUsers[index].userGeneralInfo
                .profilePictureUrl = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'ProfilePictureSubUser') {
            profile.userGeneralInfo.subUsers[index].userGeneralInfo
                .profilePictureUrl = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'EditProfilePicture') {
            profile.userGeneralInfo.subUsers[index].userGeneralInfo
                .profilePictureUrl = profile.parameters.fileUrl;
          }

          if (profile.parameters.location == 'InsuranceInfo') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .insuranceInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'infectionDisaces') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .infectionDisaces
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'allergies') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .allergies
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'renalKenedy') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .renalKenedy
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'cardiac') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .cardiac
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'Implants') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .implants
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'psychiatric') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .psychiatric
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'neuroligic') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .neuroligic
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'plumonary') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .plumonary
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'medication') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .medication
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'cancer') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .medicalDiseaces
                .cancer
                .blocks[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'bloodInfo') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .bloodInfo
                .diabates[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'organDonor') {
            profile.userGeneralInfo.subUsers[index].medicalRecord.organDonar
                .documents.last.data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'Dnr') {
            profile.userGeneralInfo.subUsers[index].medicalRecord.resuscitate
                .documents.last.data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'miscilanious') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .miscilanious[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'otherMedicalRecordInfo') {
            profile
                .userGeneralInfo
                .subUsers[index]
                .medicalRecord
                .otherMedicalRecordInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }

          print('Completeeeeeeed');
          return profile;
        });

    print(profile.parameters.fileUrl);
    return profile;
  }
}
