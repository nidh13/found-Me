import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';
import 'package:neopolis/Features/Notifications/Presentation/Widgets/Components/notificationItem.dart';
import 'package:neopolis/Features/Signin/Data/Datasource/Implementations/socialMediaService.dart';
import 'package:neopolis/Features/Signin/Data/Datasource/userRemoteDatasource.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mercury_client/mercury_client.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> login(LoginParams loginParams) async {
    print('Start: ' + DateTime.now().toString());
    String idUser, idLanguage, idSession;

    var client = HttpClient('https://foundme-dev.hotline.direct');
    var loginResponse;
    var statusCode;
    if (loginParams.type == "simpleLogin") {
      loginResponse = await client.get('email_sign_in?', parameters: {
        'mail': loginParams.email,
        'password': loginParams.password,
      });
      statusCode = loginResponse.status;
    } else if (loginParams.type == "socialMedia") {
      print(
          "https://foundme-dev.hotline.direct/social_network_registration?email=${loginParams.email}&sn_id=${loginParams.password}");
      loginResponse = await http.get(
        "https://foundme-dev.hotline.direct/social_network_registration?email=${loginParams.email}&sn_id=${loginParams.password}",
        headers: {
          'Content-Type': 'application/json',
          'idSession': 'test',
        },
      );
      statusCode = loginResponse.statusCode;
    }

    if (statusCode == 200) {
      print('end login: ' + DateTime.now().toString());

      idUser = json.decode(loginResponse.body)['id_user'];
      //  idLanguage = json.decode(loginResponse.body)['id_language'];
      idSession = 'test';
      //  idSession = json.decode(loginResponse.body)['idSession'];
      configOneSignal(idUser, idSession);
      print(idUser);
      final viewResponse = await http.get(
        "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
        headers: {
          'Content-Type': 'application/json',
          'idSession': idSession,
        },
      );

      if (viewResponse.statusCode == 200) {
        final profile = Profile.fromJson(json.decode(viewResponse.body));
        print(profile.userGeneralInfo.idUser);
        profile.userGeneralInfo.idUser = idUser;
        profile.userGeneralInfo.idSession = idSession;
        profile.userGeneralInfo.type = 'Email';
        profile.parameters = Parameters();
        profile.parameters.discussions = Discussions();

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
        }
        print(
            "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser");
        final tagsListResponse = await http.get(
          "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': idSession,
          },
        );
 print(
          "*0*" );
        if (tagsListResponse.statusCode == 200) {
           print(
          "*1*" );
          profile.userGeneralInfo.tagsList =
              TagsList.fromJson(json.decode(tagsListResponse.body));
        }
   print(
          "*2*" );
        final notificationsListResponse = await http.get(
          "https://foundme-dev.hotline.direct/get_translated_notifcations_by_type_and_archive?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': "test",
          },
        );

        if (notificationsListResponse.statusCode == 200) {
          profile.userGeneralInfo.notificationlist = Notifications.fromJson(
              json.decode(notificationsListResponse.body));
 print(
          "*3*" );
          print(profile.userGeneralInfo.notificationlist);
        }

        final homeParametersResponse = await http.get(
          "https://foundme-dev.hotline.direct/get_all_app_parameters?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': "test",
          },
        );

        if (homeParametersResponse.statusCode == 200) {
          Map<String, dynamic> homeMap =
              json.decode(homeParametersResponse.body);
          profile.parameters.homeParameters = homeMap;

          List<Map<String, dynamic>> eyeColorList = [];
          List<dynamic> eyeColorbody =
              json.decode(homeParametersResponse.body)['eye_colors'];
          eyeColorbody.forEach((element) {
            eyeColorList.add(element);
          });
          profile.parameters.eyeColorList = eyeColorList;

          List<Map<String, dynamic>> bloodList = [];
          List<dynamic> bloodbody =
              json.decode(homeParametersResponse.body)['bloods_types'];
          bloodbody.forEach((element) {
            bloodList.add(element);
          });
          profile.parameters.bloodList = bloodList;

          List<Map<String, dynamic>> genderList = [];
          List<dynamic> genderbody =
              json.decode(homeParametersResponse.body)['gendres'];
          genderbody.forEach((element) {
            genderList.add(element);
          });
          profile.parameters.genderList = genderList;

          List<Map<String, dynamic>> materialStatusList = [];
          List<dynamic> materialStatusbody =
              json.decode(homeParametersResponse.body)['material_status'];
          materialStatusbody.forEach((element) {
            materialStatusList.add(element);
          });

          profile.parameters.materialStatusList = materialStatusList;
          List<Map<String, dynamic>> themeColor = [];
          List<dynamic> themeColors =
              json.decode(homeParametersResponse.body)['theme_color'];
          themeColors.forEach((element) {
            themeColor.add(element);
          });
          profile.parameters.themeColor = themeColor;

          Map<String, dynamic> faq = {};
          Map<String, dynamic> decoded = json
              .decode(homeParametersResponse.body)['questions_marks'] as Map;
          decoded.forEach((key, value) {
            faq.addAll({key: value});
          });
          profile.parameters.faq = faq;

          List<Map<String, dynamic>> tagTypesList = [];
          List<dynamic> tagTypesbody =
              json.decode(homeParametersResponse.body)['tag_types'];
          tagTypesbody.forEach((element) {
            tagTypesList.add(element);
          });
          profile.parameters.tagTypesList = tagTypesList;

          List<Map<String, dynamic>> petTypesList = [];
          List<dynamic> body =
              json.decode(homeParametersResponse.body)['pet_types'];
          body.forEach((element) {
            petTypesList.add(element);
          });
          profile.parameters.petTypesList = petTypesList;

          List<Map<String, dynamic>> roleUsers = [];
          List<dynamic> roleUsersbody =
              json.decode(homeParametersResponse.body)['roles'];
          roleUsersbody.forEach((element) {
            roleUsers.add(element);
          });
          profile.parameters.roleUser = roleUsers;
/*
          final localesResponse = await http.get(
            "https://foundme-dev.hotline.direct/get_translate_text_and_label?id_language=50",
            headers: {
              'Content-Type': 'application/json',
              'idSession': "test",
            },
          );
          if (localesResponse.statusCode == 200) {
            Map<String, dynamic> locales = {};
            Map<String, dynamic> decodedJson =
                json.decode(localesResponse.body) as Map;
            decodedJson.forEach((key, value) {
              locales.addAll({key: value});
            });
            profile.parameters.locales = locales;
          }
*/
        } else {
          throw ServerExeption();
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("stayConnected", true);
        prefs.setString("email", loginParams.email);
        prefs.setString("password", loginParams.password);
        if (loginParams.type == 'socialMedia') {
          prefs.setString("type", "socialMedia");
        } else if (loginParams.type == "simpleLogin") {
          prefs.setString("type", "simpleLogin");
        }
        print('End: ' + DateTime.now().toString());
        print( profile.parameters.themeColor[profile.userGeneralInfo.currentColor-1]['color']);
        // Color color;
        String codeCouleur = "0xff" +
            profile.parameters
                .themeColor[profile.userGeneralInfo.currentColor - 1]['color'];
        // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
        ColorConstant.pinkColor = Color(int.parse(codeCouleur));
        return profile;
      } else if (viewResponse.statusCode == 401) {
        final profile = Profile(
          userGeneralInfo: UserGeneralInfo(idUser: 'Session expired'),
        );
        return profile;
      } else {
        throw ServerExeption();
      }
    } else if (loginResponse.status == 403) {
      if (json.decode(loginResponse.body)['message'] == 'User does not exist') {
        final profile = Profile(
          userGeneralInfo: UserGeneralInfo(idUser: 'User does not exist'),
        );
        return profile;
      }
      if (json.decode(loginResponse.body)['message'] == 'Wrong password') {
        final profile = Profile(
          userGeneralInfo: UserGeneralInfo(idUser: 'Wrong password'),
        );
        return profile;
      }
      if (json.decode(loginResponse.body)['message'] ==
          'You cannot process login until you activate your account') {
        final profile = Profile(
          userGeneralInfo: UserGeneralInfo(
              idUser:
                  'You cannot process login until you activate your account'),
        );
        return profile;
      }
      final profile = Profile(
        userGeneralInfo: UserGeneralInfo(idUser: 'Login issues'),
      );
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Profile> loginGoogle(String test) async {
    Profile profile = await SocialMediaService().signInWithGoogle();
    print(profile);
    return profile;
  }

  @override
  Future<Profile> loginFacebook(String test) async {
    Profile profile = await SocialMediaService().loginWithFB();
    profile;
    return profile;
  }

  @override
  Future<String> register(RegisterParams registerParams) async {
    final response = await http.get(
      "https://foundme-dev.hotline.direct/email_sign_up?first_name=${registerParams.firstName}&last_name=${registerParams.lastName}&password=${registerParams.password}&confirm_email=true&primary_email=${registerParams.email}",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      final message = json.decode(response.body)['message'];
      return message;
    } else if (response.statusCode == 400 ||
        response.statusCode == 402 ||
        response.statusCode == 404 ||
        response.statusCode == 406 ||
        response.statusCode == 500) {
      final message = json.decode(response.body)['message'];
      return message;
    } else {
      throw ServerExeption();
    }
  }

  configOneSignal(String idUs, String idSess) async {
    await OneSignal.shared.init('a5f4086c-3644-4cfb-854d-5357eb2fa9c5');
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    var status = await OneSignal.shared.getPermissionSubscriptionState();
    print(status);
    var playerId = status.subscriptionStatus.userId;
    // print(" player id before api " + playerId);

    final savePlayeIDResponse = await http.get(
      "https://foundme-dev.hotline.direct/liste_devices_per_user?id_device=$playerId&id_user=$idUs",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSess,
      },
    );
    print(savePlayeIDResponse.body);
    if (savePlayeIDResponse.statusCode == 200) {
      print('playerId: $playerId');
    } else {
      throw ServerExeption();
    }

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      print('playerIdz: $playerId');
    });
  }

  @override
  Future<String> forgotPassword(String email) async {
    final response = await http.get(
      "https://ws.interface-crm.com:444/send_link_restore_pwd?mail=$email",
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      final message = json.decode(response.body)['message'];
      return message;
    } else if (response.statusCode == 400 ||
        response.statusCode == 402 ||
        response.statusCode == 404 ||
        response.statusCode == 406 ||
        response.statusCode == 500) {
      final message = json.decode(response.body)['message'];
      return message;
    } else {
      throw ServerExeption();
    }
  }
}
