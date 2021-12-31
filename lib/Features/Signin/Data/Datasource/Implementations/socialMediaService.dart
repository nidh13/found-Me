import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';

class SocialMediaService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = FacebookLogin();
  String idSession = "test";
  bool a;
  Future<Profile> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    // Profile(
    //     userGeneralInfo: UserGeneralInfo(
    //       petsInfos: List<PetsInfos>(),
    //       address: Address(),
    //       active: 1,
    //       idSubUser: null,
    //       birthInfo: BirthDateInfo(day: '01', month: '01', year: 2020),
    //       birthDate: "Fri, 29 Jan 1993 00:00:00 GMT",
    //       userTags: UserTags(
    //           medicalTag: List<MedicalTag>(), objectTag: List<ObjectTag>()),
    //       preferenceUser: PreferenceUser(
    //           allowLiveChat: Allow(value: '0'),
    //           allowShareEmails: Allow(value: '0'),
    //           allowShareName: Allow(value: '0'),
    //           allowSharePhone: Allow(value: '0'),
    //           allowSharePicture: Allow(value: '0'),
    //           includeMail1: Allow(value: '0'),
    //           includeMail2: Allow(value: '0'),
    //           includeMobile: Allow(value: '0'),
    //           shareChildName: Allow(value: '0'),
    //           shareChildPicture: Allow(value: '0')),
    //       userEmergencyContact: List<UserEmergencyContact>(),
    //       subUsers: List<Profile>(),
    //     ),
    //     medicalRecord: MedicalRecord(
    //         organDonar: OrganDonor(documents: List<Documents>()),
    //         heightweight: Heightweight(),
    //         resuscitate: Resuscitate(documents: List<Documents>()),
    //         insuranceInfo: List<InsuranceInfo>(),
    //         miscilanious: List<Miscilanious>(),
    //         otherMedicalRecordInfo: List<OtherMedicalRecordInfo>(),
    //         userEmergencyContact: List<UserEmergencyContact>(),
    //         bloodInfo: BloodInfo(diabates: List<Diabates>()),
    //         physicianContact: List<PhysicianContact>(),
    //         medicalDiseaces: MedicalDiseaces(
    //             allergies: Allergies(
    //               blocks: List<Blocks>(),
    //             ),
    //             cancer: Cancer(blocks: List<Blocks>()),
    //             cardiac: Allergies(blocks: List<Blocks>()),
    //             implants: Allergies(blocks: List<Blocks>()),
    //             infectionDisaces: Allergies(blocks: List<Blocks>()),
    //             medication: Allergies(blocks: List<Blocks>()),
    //             plumonary: Allergies(blocks: List<Blocks>()),
    //             psychiatric: Allergies(blocks: List<Blocks>()),
    //             renalKenedy: Allergies(blocks: List<Blocks>()),
    //             neuroligic: Allergies(blocks: List<Blocks>()))),
    //     parameters: Parameters());
    String idUser;
    String idSession;
    Profile profile;
    try {
      await _googleSignIn.signIn().then((value) async {
        final getUserParameter = await http.get(
          "https://foundme-dev.hotline.direct/social_network_registration?first_name=${value.displayName}&email=${value.email}&sn_id=${value.id}",
          headers: {
            'Content-Type': 'application/json',
            'idSession': 'test',
          },
        );
        if (getUserParameter.statusCode == 200) {
          var body = json.decode(getUserParameter.body);
          idUser = body['id_user'];
          idSession = body['idSession'];

          final viewResponse = await http.get(
            "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
            headers: {
              'Content-Type': 'application/json',
              'idSession': idSession,
            },
          );

          if (viewResponse.statusCode == 200) {
            profile = Profile.fromJson(json.decode(viewResponse.body));
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

            final tagsListResponse = await http.get(
              "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
              headers: {
                'Content-Type': 'application/json',
                'idSession': idSession,
              },
            );

            if (tagsListResponse.statusCode == 200) {
              profile.userGeneralInfo.tagsList =
                  TagsList.fromJson(json.decode(tagsListResponse.body));
            }

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

              Map<String, dynamic> faq = {};
              Map<String, dynamic> decoded =
                  json.decode(homeParametersResponse.body)['questions_marks']
                      as Map;
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
              profile.userGeneralInfo.googleSign = googleSignIn;
            } else {
              throw ServerExeption();
            }

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool("stayConnected", true);
            prefs.setString("email", value.email);
            prefs.setString("password", value.id);
            prefs.setString("type", "socialMedia");

            print('End: ' + DateTime.now().toString());
          } else {}
        } else {
          profile.userGeneralInfo.message = 'Email required';
          return profile;
        }
      });

      print('End: ' + DateTime.now().toString());
      return profile;
    } catch (err) {
      print(err);
    }
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<Profile> loginWithFB() async {
    var facebookLogin = new FacebookLogin();
    final result = await facebookLogin.logIn(['email', 'public_profile']);
    FacebookAccessToken myToken = result.accessToken;
    String idUser;
    String email;

    Profile profile = Profile();
    print(result.status);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final token = myToken.token;
      final id = myToken.userId;
      final response = await http.get(
          'https://graph.facebook.com/$id?fields=name,first_name,last_name,email&access_token=${token}');

      // profile.userGeneralInfo.firstName = json.decode(response.body)['name'];
      // profile.userGeneralInfo.lastName = '';
      email = json.decode(response.body)['email'];
      //  profile.userGeneralInfo.type = 'Facebook';
      final getUserParameter = await http.get(
        "https://foundme-dev.hotline.direct/social_network_registration?first_name=${json.decode(response.body)['name']}&email=${json.decode(response.body)['email']}&sn_id=${id}",
        headers: {
          'Content-Type': 'application/json',
          'idSession': 'test',
        },
      );
      if (getUserParameter.statusCode == 200) {
        var body = json.decode(getUserParameter.body);
        idUser = body['id_user'];
        idSession = body['idSession'];

        final viewResponse = await http.get(
          "https://foundme-dev.hotline.direct/view_user?id_user=$idUser",
          headers: {
            'Content-Type': 'application/json',
            'idSession': idSession,
          },
        );

        if (viewResponse.statusCode == 200) {
          profile = Profile.fromJson(json.decode(viewResponse.body));
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

          final tagsListResponse = await http.get(
            "https://foundme-dev.hotline.direct/organise_tag_by_categorie_and_member?id_user=$idUser",
            headers: {
              'Content-Type': 'application/json',
              'idSession': idSession,
            },
          );

          if (tagsListResponse.statusCode == 200) {
            profile.userGeneralInfo.tagsList =
                TagsList.fromJson(json.decode(tagsListResponse.body));
          }

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
          } else {
            throw ServerExeption();
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("stayConnected", true);
          prefs.setString("email", email);
          prefs.setString("password", myToken.userId);
          prefs.setString("type", "socialMedia");

          print('End: ' + DateTime.now().toString());
          profile.userGeneralInfo.facebookSignIn = facebookSignIn;
          return profile;
        } else {}
      }
    } else {
      profile.userGeneralInfo.message = 'Email required';
      return profile;
    }
  }
}
