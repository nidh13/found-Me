import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Features/Messages/Data/Datasource/messagesRemoteDatasource.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';
import 'package:path/path.dart';

class MessagesRemoteDataSourceImpl implements MessagesRemoteDataSource {
  final http.Client client;

  MessagesRemoteDataSourceImpl({@required this.client});

  @override
  Future<Profile> listMessages(Profile profile) async {
    profile.userGeneralInfo.message = null;

    final responseOpenRoom = await http.get(
      "https://foundme-dev.hotline.direct/open_room?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}",
    );
    if (responseOpenRoom.statusCode == 200) {
      profile.userGeneralInfo.zulipAcces.queueId =
          json.decode(responseOpenRoom.body)['queue_id'];
    } else {
      profile.userGeneralInfo.message =
          'Sever failure \n Please try again in few seconds';
      return profile;
    }

    final response = await http.get(
      "https://foundme-dev.hotline.direct/get_all_disscussion?username_owner=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}",
    );

    if (response.statusCode == 200) {
      profile.parameters.discussions =
          Discussions.fromJson(json.decode(response.body));
      return profile;
    } else if (response.statusCode != 200) {
      profile.userGeneralInfo.message =
          'Sever failure \n Please try again in few seconds';
      profile.parameters.discussions = Discussions();
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Profile> goToSpecificMessage(Profile profile) async {
    String discussionMails = '';
    profile.parameters.discussionMails.forEach((element) {
      discussionMails = discussionMails + ',' + element;
    });

    final responseOpenRoom = await http.get(
      "https://foundme-dev.hotline.direct/open_room?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}",
    );
    if (responseOpenRoom.statusCode == 200) {
      profile.userGeneralInfo.zulipAcces.queueId =
          json.decode(responseOpenRoom.body)['queue_id'];
    } else {}

    final response = await http.get(
      "https://foundme-dev.hotline.direct/get_message_disscusion?username_owner=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}&username=${profile.userGeneralInfo.zulipAcces.zulipMail}$discussionMails",
    );

    if (response.statusCode == 200) {
      print("end get_message_disscusion " + DateTime.now().toString());

      profile.parameters.specificDiscussion =
          SpecificDiscussion.fromJson(json.decode(response.body));
      profile.parameters.specificDiscussion.specificMessage = profile
          .parameters.specificDiscussion.specificMessage.reversed
          .toList();
      return profile;
    } else if (response.statusCode != 200) {
      profile.userGeneralInfo.message =
          'Sever failure \n Please try again in few seconds';
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Profile> sendMessage(Profile profile) async {
    String idUser = profile.userGeneralInfo.idUser;

    String discussionMails = '';
    profile.parameters.discussionMails.forEach((element) {
      discussionMails = discussionMails + ',' + element;
    });
    discussionMails = discussionMails.substring(1, discussionMails.length);

    if (profile.parameters.specificMessage.isFile) {
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
          'idSession': 'test',
        },
      );

      request.files.add(multipartFile);
      var response = await request.send();
      response.stream
          .transform(utf8.decoder)
          .listen((event) async {
            try {
              var value = await jsonDecode(event);
              if (value['error'] == false) {
                profile.parameters.fileUrl = value['url'];
              }
            } on Exception catch (_) {
              print("Error uploading");
            }
          })
          .asFuture()
          .then((value) async {
            print(profile.parameters.fileUrl);
            profile.parameters.specificMessage.message =
                '[photo]:' + profile.parameters.fileUrl;
          });

      String message = profile.parameters.specificMessage.message;
      final responsee = await http.get(
        'https://foundme-dev.hotline.direct/send_message_event?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}&content=$message&to=$discussionMails&type=private',
      );

      if (responsee.statusCode == 200) {
        profile.parameters.specificDiscussion.specificMessage.insert(
          0,
          profile.parameters.specificMessage,
        );
        return profile;
      } else if (responsee.statusCode != 200) {
        profile.userGeneralInfo.message =
            json.decode(responsee.body)['message'];
        return profile;
      } else {
        throw ServerExeption();
      }
    } else {
      final response = await http.get(
        'https://foundme-dev.hotline.direct/send_message_event?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}&content=${profile.parameters.specificMessage.message}&to=$discussionMails&type=private',
      );

      if (response.statusCode == 200) {
        return profile;
      } else if (response.statusCode != 200) {
        profile.userGeneralInfo.message = json.decode(response.body)['message'];
        return profile;
      } else {
        throw ServerExeption();
      }
    }
  }

  @override
  Future<Profile> deleteDiscussion(Profile profile) async {
    String discussionMails = '';

    profile.parameters.discussionMails.forEach((element) {
      discussionMails = discussionMails + ',' + element;
    });

    final response = await http.get(
      "https://foundme-dev.hotline.direct/delete_disscussion?username_owner=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}&username=${profile.userGeneralInfo.zulipAcces.zulipMail}$discussionMails",
    );
    if (response.statusCode == 200) {
      return profile;
    } else {
      throw ServerExeption();
    }
  }
}
