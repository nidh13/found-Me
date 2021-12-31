import 'dart:async';
import 'dart:convert';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Reminders/Data/Datasource/reminderRemoteDatasource.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Error/exceptions.dart';

class ReminderRemoteDataSourceImpl implements ReminderRemoteDataSource {
  final http.Client client;
  ReminderRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> reminderList(
      DeteleReminderParams deteleReminderParams) async {
    Profile profile = deteleReminderParams.profile;
    Reminders reminders = deteleReminderParams.reminder;
    String idUser = profile.userGeneralInfo.idUser;

    //  String idSession = profile.userGeneralInfo.idSession;
    String idSession = 'test';

    final response = await http.post(
      "https://foundme-dev.hotline.direct/update_one_reminder?id_user=$idUser",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
      body: json.encode(reminders),
    );
    print(profile.userGeneralInfo.update);
    var body = json.encode(reminders);
    print(body);
    var responseUpdate = json.decode(response.body);

    print(responseUpdate);
    if (response.statusCode == 200) {
      profile.userGeneralInfo.message = 'Success';
      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
      );
      if (viewResponse.statusCode == 200) {
        profile = Profile.fromJson(json.decode(viewResponse.body));
        profile.parameters = profile.parameters;
        profile.userGeneralInfo.idUser = profile.userGeneralInfo.idUser;
        profile.userGeneralInfo.message = 'Success';
        final remindersResponse = await http.get(
          "https://foundme-dev.hotline.direct/list_reminder_user_member_categorie_by_filter?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': idSession,
          },
        );
        if (remindersResponse.statusCode == 200) {
          profile.userGeneralInfo.remindersList =
              RemindersList.fromJson(json.decode(remindersResponse.body));

          print(profile.userGeneralInfo.remindersList);
        }
      } else {
        throw ServerExeption();
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
