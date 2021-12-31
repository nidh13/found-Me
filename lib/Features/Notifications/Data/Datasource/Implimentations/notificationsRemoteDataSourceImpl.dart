import 'dart:async';
import 'dart:convert';
import 'package:neopolis/Core/Utils/parameters.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Features/Notifications/Data/Datasource/notificationsRemoteDatasource.dart';

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final http.Client client;
  NotificationsRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> editnotifications(
      EditNotificationsParams addEditUsersParams) async {
    Profile profile = addEditUsersParams.profile;
    int index = addEditUsersParams.index;
    String idUser = profile.userGeneralInfo.idUser;
    String idNotif = profile.userGeneralInfo.notificationlist
        .whenObjectIsScanned.content[index].idNotifcation;
    String idSession = 'test';
    profile.userGeneralInfo.notificationlist.whenObjectIsScanned.content[index]
        .active = 0;
    profile.userGeneralInfo.notificationlist.whenObjectIsScanned.content[index]
        .archive = 1;
    print(
      "https://ws.interface-crm.com:444/archive_notification_by_type_notification_or_id?id_notification=$idNotif&key=by_id&id_user=$idUser",
    );
    final response = await http.get(
      "https://ws.interface-crm.com:444/archive_notification_by_type_notification_or_id?id_notification=$idNotif&key=by_id&id_user=$idUser",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
    );

    if (response.statusCode == 200) {
      //  profile.userGeneralInfo.message = 'Success';
      final notificationsListResponse = await http.get(
        "https://foundme-dev.hotline.direct/get_translated_notifcations_by_type_and_archive?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': "test",
        },
      );

      if (notificationsListResponse.statusCode == 200) {
        profile.userGeneralInfo.notificationlist =
            Notifications.fromJson(json.decode(notificationsListResponse.body));

        print(profile.userGeneralInfo.notificationlist);
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
