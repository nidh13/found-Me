import 'dart:async';
import 'dart:convert';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Pets/Data/Datasource/petsRemoteDatasource.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/uploadFilePets.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Error/exceptions.dart';

class PetsRemoteDataSourceImpl implements PetsRemoteDataSource {
  final http.Client client;
  PetsRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> editProfilePets(
      AddEditUploadFilePetsParams addEditUsersParams) async {
    Profile profile = addEditUsersParams.profile;
    int index = addEditUsersParams.index;
    String idUser = profile.userGeneralInfo.idUser;

    //  String idSession = profile.userGeneralInfo.idSession;
    String idSession = 'test';
    Profile profilee;
    if (profile.parameters.location == 'View Pet') {
      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
      );
      var body = json.encode(profile.userGeneralInfo.petsInfos[index].toJson());
      print(body);
      var responseUpdate = json.decode(viewResponse.body);
      print(responseUpdate);

      if (viewResponse.statusCode == 200) {
        TagsList tagsList = profile.userGeneralInfo.tagsList;
         Notifications notifications = profile.userGeneralInfo.notificationlist;
        RemindersList reminders = profile.userGeneralInfo.remindersList;
        profilee = Profile.fromJson(json.decode(viewResponse.body));
        profilee.parameters = profile.parameters;
        profilee.userGeneralInfo.idUser = profile.userGeneralInfo.idUser;
        profile = profilee;
        profile.userGeneralInfo.tagsList = tagsList;
   profile.userGeneralInfo.notificationlist = notifications;
        profile.userGeneralInfo.remindersList = reminders;
          profile.userGeneralInfo.tagsList = tagsList;
        //   profile.userGeneralInfo.message = 'Success';

        return profile;
      } else {
        throw ServerExeption();
      }
    } else if (profile.parameters.location == 'View save pet') {
      var body = json.encode(profile.userGeneralInfo.petsInfos[index].toJson());
      print(body);
      final response = await http.post(
        "https://foundme-dev.hotline.direct/add_edit_pet_info?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.userGeneralInfo.petsInfos[index]),
      );
      //  var body = json.encode(profile.userGeneralInfo.petsInfos[index].toJson());
      print(body);
      var responseUpdate = json.decode(response.body);
      print(responseUpdate);
      if (response.statusCode == 200) {
        profile.userGeneralInfo.message = 'Success';
        responseUpdate.forEach((element) {
          profile.userGeneralInfo.petsInfos[index].generalInfo.idPet =
              element['id_pet'];
          if (profile.userGeneralInfo.petsInfos[index].petTag.length != 0) {
            profile.userGeneralInfo.petsInfos[index].petTag
                .forEach((petTagelement) {
              petTagelement.tagInfo.idTag = element['id_tag'];
            });
          }
        });
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
        final viewResponse = await http.get(
          "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
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
          profilee.userGeneralInfo.idUser = profile.userGeneralInfo.idUser;
          profile = profilee;
            profile.userGeneralInfo.notificationlist = notifications;
        profile.userGeneralInfo.remindersList = reminders;
          profile.userGeneralInfo.tagsList = tagsList;
        }
        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    } else {
      var body = json.encode(profile.userGeneralInfo.petsInfos[index].toJson());
      print(body);
      final response = await http.post(
        "https://foundme-dev.hotline.direct/add_edit_pet_info?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.userGeneralInfo.petsInfos[index]),
      );
      if(profile.userGeneralInfo.petsInfos[index].generalInfo.delete==1){
        profile.parameters.location='deletePet';
      }
    //   var body = json.encode(profile.userGeneralInfo.petsInfos[index].toJson());
      print(body);
      var responseUpdate = json.decode(response.body);
      print(responseUpdate);
      if (response.statusCode == 200) {
        profile.userGeneralInfo.message = 'Success';
        responseUpdate.forEach((element) {
          profile.userGeneralInfo.petsInfos[index].generalInfo.idPet =
              element['id_pet'];
          if (profile.userGeneralInfo.petsInfos[index].petTag.length != 0) {
            profile.userGeneralInfo.petsInfos[index].petTag
                .forEach((petTagelement) {
              petTagelement.tagInfo.idTag = element['id_tag'];
            });
          }
        });

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
        final viewResponse = await http.get(
          "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
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
          profilee.userGeneralInfo.idUser = profile.userGeneralInfo.idUser;
          profilee.parameters.location=profile.parameters.location;
          profile = profilee;
           profile.userGeneralInfo.notificationlist = notifications;
        profile.userGeneralInfo.remindersList = reminders;
          profile.userGeneralInfo.tagsList = tagsList;
         
          
        }
        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Profile> uploadFilePets(
      AddEditUploadFilePetsParams addEditUploadFileUsersParams) async {
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

    profile.parameters.fileUrl =
        'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg';

    request.files.add(multipartFile);
    var response = await request.send();
    response.stream
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
            profile.userGeneralInfo.petsInfos[index].generalInfo.idPicture =
                null;
            profile.userGeneralInfo.petsInfos[index].generalInfo.picturePet =
                profile.parameters.fileUrl;
                
          }

          if (profile.parameters.location == 'otherInfo') {
            profile
                .userGeneralInfo
                .petsInfos[index]
                .otherInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'vaccine') {
            profile
                .userGeneralInfo
                .petsInfos[index]
                .vaccins[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }

          print('Completeeeeeeed');
          return profile;
        });
    return profile;
  }

  @override
  Future<Profile> addTagPets(
      AddEditUploadFilePetsParams addEditUsersParams) async {
    Profile profile = addEditUsersParams.profile;
    int index = addEditUsersParams.index;
    String idUser = profile.userGeneralInfo.idUser;
    final String serial = profile.parameters.serial;
    final String idMember = profile.userGeneralInfo.idMember;
    int indexu;
    //  String idSession = profile.userGeneralInfo.idSession;
    String idSession = 'test';
    print(
      "https://foundme-dev.hotline.direct/scan_tag?serial_number=$serial&id_user=$idUser&id_member=$idMember",
    );
    final response = await http.get(
      "https://foundme-dev.hotline.direct/scan_tag?serial_number=$serial&id_user=$idUser&id_member=$idMember",
      headers: {
        'Content-Type': 'application/json',
        'idSession': 'test',
      },
    );

    print(response.statusCode);
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
      if (profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTagCategorie ==
          3) {
        PetTag petTag = PetTag(
          otherInfo: List<OtherInfo>(),
          preferenceUser: profile.userGeneralInfo.petsInfos.last.preferencePet,
          emergencyContactUser:
              profile.userGeneralInfo.petsInfos.last.emergencyContact,
          tagUserInfo: TagUserInfo(
            idUser: profile.userGeneralInfo.petsInfos.last.generalInfo.idPet
                .toString(),
            firstName: profile.userGeneralInfo.petsInfos.last.generalInfo.name,
          ),
          tagInfo: TagInfo(
              idType: null,
              idTag: profile.userGeneralInfo.newTags.newTag.last.tagInfo.idTag,
              serialNumber: serial,
              idTagCategorie: 3,
              active: 1,
              archive: 0,
              emergency: 0,
              idMember:
                  profile.userGeneralInfo.newTags.newTag.last.tagInfo.idMember),
        );
        profile.userGeneralInfo.petsInfos[index].petTag.add(petTag);
      } else {
        profile.userGeneralInfo.message = 'This is not a pet serial number';
      }
      return profile;
    } else if (json.decode(response.body)["error"] == true) {
      //  profile.parameters.result.add({"error": "error"});

      profile.userGeneralInfo.message = json.decode(response.body)["message"];
      print(profile.userGeneralInfo.message);
      return profile;
    } else if (response.statusCode == 500) {
      profile.userGeneralInfo.message =
          'Server failure it will be up in a minute';
      return profile;
    } else {
      throw ServerExeption();
    }
  }
}
