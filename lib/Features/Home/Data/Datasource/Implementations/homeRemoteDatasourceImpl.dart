import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Home/Data/Datasource/homeRemoteDatasource.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;

  HomeRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> resetPassword(ResetPasswordParams resetPasswordParams) async {
    Profile profile = resetPasswordParams.profile;
    String idUser = resetPasswordParams.profile.userGeneralInfo.idUser;
    String idSession = resetPasswordParams.profile.userGeneralInfo.idSession;
    String oldPassword = resetPasswordParams.oldPassword;
    String newPassword = resetPasswordParams.newPassword;

    final response = await http.get(
      "https://ws.interface-crm.com:444/update_password?id_user=$idUser&current_password=$oldPassword&new_password=$newPassword",
      headers: {
        'Content-Type': 'application/json',
        'idSession': 'test',
      },
    );

    if (response.statusCode == 202) {
      profile.userGeneralInfo.message = json.decode(response.body)['message'];
      return profile;
    } else if (response.statusCode != 202) {
      profile.userGeneralInfo.message = json.decode(response.body)['message'];
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<String> logout(Profile profile) async {
    final String idUser = profile.userGeneralInfo.idUser;
    final String idSession = profile.userGeneralInfo.idSession;

    final response = await http.get(
      "https://foundme-dev.hotline.direct/logout?id_user=$idUser",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
    );

    if (response.statusCode == 202) {
      final message = json.decode(response.body)['message'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("stayConnected", false);
      // if (profile.userGeneralInfo.googleSign.currentUser != null) {
      //   await profile.userGeneralInfo.googleSign.signOut();
      // }
      return message;
    } else if (response.statusCode != 200) {
      final message = 'An error occured';
      return message;
    } else {
      throw ServerExeption();
    }
  }
}
