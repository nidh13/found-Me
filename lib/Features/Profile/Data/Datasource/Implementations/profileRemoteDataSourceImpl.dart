import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Features/Profile/Data/Datasource/profileRemoteDatasource.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({@required this.client});
  Profile profilee;

  @override
  Future<Profile> editProfile(Profile profile) async {
    String idUser = profile.userGeneralInfo.idUser;
    String idLanguage = profile.userGeneralInfo.userIdLanguage;
    String idSession = profile.userGeneralInfo.idSession;
    if (profile.parameters.location == 'profile') {
      print(DateTime.now());

      final response = await http.post(
        "https://foundme-dev.hotline.direct/update_profile?id_user=$idUser&userIdLanguage=$idLanguage",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.toJson()),
      );

      var body = json.encode(profile.toJson());
      print(body);
      if (response.statusCode == 202) {
        profile.userGeneralInfo.message = 'Success';
        print('end ' + DateTime.now().toString());
 Profile profilee;

      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
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

       
      
      }
        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    }
    if (profile.parameters.location == 'Edit profile') {
      print(DateTime.now());
      final response = await http.post(
        "https://foundme-dev.hotline.direct/update_profile?id_user=$idUser&userIdLanguage=$idLanguage",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.toJson()),
      );

      var body = json.encode(profile.toJson());
      print(body);
      if (response.statusCode == 202) {
        profile.userGeneralInfo.message = 'Success';
        print('end' + DateTime.now().toString());
 Profile profilee;

      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
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

       
      
      }
        profile.parameters.location = "view home";
        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    }
    if (profile.parameters.location == 'Edit view profile') {
      print(DateTime.now());
      final response = await http.post(
        "https://foundme-dev.hotline.direct/update_profile?id_user=$idUser&userIdLanguage=$idLanguage",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
        body: json.encode(profile.toJson()),
      );

      var body = json.encode(profile.toJson());
      print(body);
      if (response.statusCode == 202) {
       Profile profilee;

      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
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

       
      
      }

        return profile;
      } else if (response.statusCode != 202) {
        profile.userGeneralInfo.message = 'Error';
        return profile;
      } else {
        throw ServerExeption();
      }
    }
    if (profile.parameters.location == 'view home') {
      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser&idLanguage=$idLanguage",
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
        profile.userGeneralInfo.tagsList = tagsList;
          profile.userGeneralInfo.notificationlist = notifications;
        profile.userGeneralInfo.remindersList = reminders;
        profile.userGeneralInfo.message = 'Success';

        return profile;
      } else {
        throw ServerExeption();
      }
    } else {
      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser&idLanguage=$idLanguage",
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
        profile.userGeneralInfo.remindersList=reminders;
        profile.userGeneralInfo.notificationlist=notifications;
        profile.userGeneralInfo.tagsList = tagsList;
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

  @override
  Future<Profile> uploadFile(Profile profile) async {
    String idUser = profile.userGeneralInfo.idUser;
    //  String idSession = profile.userGeneralInfo.idSession;

    String idSession = 'test';

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
          if (profile.parameters.location == 'ProfilePicture') {
            profile.userGeneralInfo.profilePictureUrl =
                profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'InsuranceInfo') {
            profile
                .medicalRecord
                .insuranceInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'infectionDisaces') {
            profile
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
                .medicalRecord
                .bloodInfo
                .diabates[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'miscilanious') {
            profile.medicalRecord.miscilanious[profile.parameters.locationIndex]
                .documents.last.data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'otherMedicalRecordInfo') {
            profile
                .medicalRecord
                .otherMedicalRecordInfo[profile.parameters.locationIndex]
                .documents
                .last
                .data = profile.parameters.fileUrl;
          }
          if (profile.parameters.location == 'organDonor') {
            profile.medicalRecord.organDonar.documents.last.data =
                profile.parameters.fileUrl;
          }

          if (profile.parameters.location == 'Dnr') {
            profile.medicalRecord.resuscitate.documents.last.data =
                profile.parameters.fileUrl;
          }

          print('Completeeeeeeed');
          return profile;
        });
    return profile;
  }
}
