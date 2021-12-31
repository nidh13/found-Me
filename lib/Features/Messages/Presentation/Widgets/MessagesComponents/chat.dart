import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';
import 'package:neopolis/Features/Messages/Presentation/bloc/messages_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:soundpool/soundpool.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class Chat extends StatefulWidget {
  final Profile profile;

  Chat({@required this.profile});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var screenWidth, screenHeight;
  final textFieldController = TextEditingController();
  List<bool> visibility = [];
  String op;
  bool isTyping = false;
// final List<MapMarker> markers = [];
//   markers.add(
//       MapMarker(
//          id: markerLocations.indexOf(markerLocation).toString(),
//          position: markerLocation,
//          icon: markerImage,
//       ),
//    );

  Soundpool pool = Soundpool(streamType: StreamType.notification);
  int soundId;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // Location location = new Location();

  // bool _serviceEnabled;
  // PermissionStatus _permissionGranted;
  // LocationData _locationData;

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  @override
  void initState() {
    super.initState();

    if (widget.profile.userGeneralInfo.message != null &&
        widget.profile.userGeneralInfo.message != 'null') {
      Future.delayed(
        Duration.zero,
        () => showOverlay(context, "problem_infos".tr(),
            'Sever failure \n Please try again in few seconds'),
      );
      widget.profile.userGeneralInfo.message = null;
    }

    widget.profile.userGeneralInfo.zulipAcces.lastEventId = -1;
    print('InitState LastEventID: ' +
        widget.profile.userGeneralInfo.zulipAcces.lastEventId.toString());
    for (int i = 0;
        i <=
            widget.profile.parameters.specificDiscussion.specificMessage.length;
        i++) {
      visibility.add(false);
    }

    soundInit();
    fetchMessages(widget.profile);
  }

  soundInit() async {
    soundId = await rootBundle
        .load("Assets/Sounds/sound.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
  }

  Future<NewMessage> fetchMessages(Profile profile) async {
    final String mail = profile.userGeneralInfo.zulipAcces.zulipMail;
    final String apiKey = profile.userGeneralInfo.zulipAcces.zulipApiKey;
    final String queueID = profile.userGeneralInfo.zulipAcces.queueId;
    final int lastEventID = profile.userGeneralInfo.zulipAcces.lastEventId;
    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$mail:$apiKey'));

    print('Executing API LastEventID: ' +
        profile.userGeneralInfo.zulipAcces.lastEventId.toString());

    http.Response response;
    try {
      response = await http.get(
        "https://foundme-dev.hotline.direct/events?email=$mail&api_key=$apiKey&queue_id=$queueID&last_event_id=$lastEventID",
        headers: {
          'Authorization': basicAuth,
          'idsession': "test",
          'reciever': mail,
          'api_key': apiKey,
        },
      );
    } on Exception catch (_) {
      print('Error');
    }

    NewMessage newMessage;
    print("Status Code: " + response.statusCode.toString());
    print("Response: " + response?.body);
    if (response != null) {
      if (response.statusCode == 200) {
        newMessage = NewMessage.fromJson(json.decode(response.body));
        if (newMessage.events != null) {
          if (newMessage.events.last != null) {
            if (newMessage.events.last.op == 'start') {
              if (mounted) {
                setState(() {
                  isTyping = true;
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  isTyping = false;
                });
              }
            }
            if (newMessage.events.last.message != null) {
              print("------------------>" +
                  newMessage.events.last.message.content);
              if (profile.parameters.discussionMails
                      .contains(newMessage.events.last.message.senderEmail) &&
                  newMessage.events.last.message.senderEmail !=
                      profile.userGeneralInfo.zulipAcces.zulipMail) {
                profile.parameters.specificMessage = SpecificMessage(
                  isFile: false,
                  message: newMessage.events.last.message.content,
                  messageOwnerEmail: newMessage.events.last.message.senderEmail,
                  messageOwnerName:
                      newMessage.events.last.message.senderFullName,
                  sendTimeMessage: DateTime.now().toUtc().toString(),
                );
                if (mounted) {
                  // print('Mounted + SetState');
                  await pool.play(soundId);
                  setState(() {
                    profile.parameters.specificDiscussion.specificMessage
                        .insert(
                      0,
                      profile.parameters.specificMessage,
                    );
                    visibility.add(false);
                  });
                  String discussionMails = '';
                  profile.parameters.discussionMails.forEach((element) {
                    discussionMails = discussionMails + ',' + element;
                  });
                  response = await http.get(
                    "https://foundme-dev.hotline.direct/read_message?username_owner=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}&username=${profile.userGeneralInfo.mail}$discussionMails",
                  );
                } else {
                  // print('Unmounted + NoSetState');
                }
              }
            }
          }
          newMessage = null;
          profile.userGeneralInfo.zulipAcces.lastEventId =
              profile.userGeneralInfo.zulipAcces.lastEventId + 1;
          print('Incrementing after success 200 LastEventID: ' +
              profile.userGeneralInfo.zulipAcces.lastEventId.toString());

          fetchMessages(profile);
        } else {
          profile.userGeneralInfo.zulipAcces.lastEventId =
              profile.userGeneralInfo.zulipAcces.lastEventId + 1;
          print('Incrementing after success 200 but no messages LastEventID: ' +
              profile.userGeneralInfo.zulipAcces.lastEventId.toString());

          fetchMessages(profile);
          return newMessage;
        }
      } else {
        final responseOpenRoom = await http.get(
          "https://foundme-dev.hotline.direct/open_room?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}",
        );
        if (responseOpenRoom.statusCode == 200) {
          profile.userGeneralInfo.zulipAcces.lastEventId = -1;
          profile.userGeneralInfo.zulipAcces.queueId =
              json.decode(responseOpenRoom.body)['queue_id'];
          print('LastEventID fails, returned to -1');

          fetchMessages(profile);
        }
      }
    } else {
      final responseOpenRoom = await http.get(
        "https://foundme-dev.hotline.direct/open_room?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}",
      );
      if (responseOpenRoom.statusCode == 200) {
        profile.userGeneralInfo.zulipAcces.lastEventId = -1;
        profile.userGeneralInfo.zulipAcces.queueId =
            json.decode(responseOpenRoom.body)['queue_id'];
        print('LastEventID fails, returned to -1');

        fetchMessages(profile);
      }
    }
  }

  LatLng currentPostion;

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPostion = LatLng(position.latitude, position.longitude);
    });
  }

  GoogleMapController mapController;
  final Set<Polyline> poly = {};

  Widget _googleMap(BuildContext context) {
    return Container(
      child: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: currentPostion, zoom: 15.0),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        //  polylines: poly,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        compassEnabled: true,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final Profile profile = widget.profile;
    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    File imageFile;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Container(
            width: 375.0 * screenWidth,
            height: 128.0 * screenHeight,
            decoration: BoxDecoration(
              color: ColorConstant.pinkColor,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x33000000),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20 * screenHeight, 0, 0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  dispatchGoToMessages(profile: profile);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      radius: 28.0,
                      backgroundImage: AssetImage("Assets/Images/steve.jpg"),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "homescree_label_object".tr(),
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 18,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          profile.parameters.discussionName ?? 'Object Finder',
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 14,
                            color: Color(0xa6ffffff),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.videocam,
                    size: 30 * screenHeight,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    dispatchMeeting(profile);
                  },
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 128 * screenHeight, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                        bottomLeft: Radius.circular(12.0),
                      ),
                      child: ListView.builder(
                          reverse: true,
                          itemCount: profile.parameters.specificDiscussion
                              .specificMessage.length,
                          itemBuilder: (BuildContext context, int index) {
                            final bool isMe =
                                profile.userGeneralInfo.zulipAcces.zulipMail ==
                                    profile
                                        .parameters
                                        .specificDiscussion
                                        .specificMessage[index]
                                        ?.messageOwnerEmail;

                            print(profile.parameters.specificDiscussion
                                .specificMessage.length);

                            return Column(
                              crossAxisAlignment: isMe
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                index ==
                                        profile.parameters.specificDiscussion
                                                .specificMessage.length -
                                            1
                                    ? Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        child: Align(
                                          alignment: isMe
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          child: Text(
                                            profile
                                                .parameters
                                                .specificDiscussion
                                                .specificMessage[index]
                                                .messageOwnerName,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                index <
                                        profile.parameters.specificDiscussion
                                                .specificMessage.length -
                                            1
                                    ? profile
                                                .parameters
                                                .specificDiscussion
                                                .specificMessage[index]
                                                .messageOwnerEmail !=
                                            profile
                                                .parameters
                                                .specificDiscussion
                                                .specificMessage[index + 1]
                                                .messageOwnerEmail
                                        ? Container(
                                            padding: EdgeInsets.fromLTRB(
                                              8.0,
                                              14.0,
                                              8.0,
                                              1,
                                            ),
                                            child: Align(
                                              alignment: isMe
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              child: Text(
                                                profile
                                                    .parameters
                                                    .specificDiscussion
                                                    .specificMessage[index]
                                                    .messageOwnerName,
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container(),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: visibility[index],
                                  child: Center(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 5, 8, 5),
                                        child: Text(
                                          Jiffy(
                                            profile
                                                .parameters
                                                .specificDiscussion
                                                .specificMessage[index]
                                                .sendTimeMessage,
                                            "yyyy-MM-dd hh:mm:ss",
                                          ).fromNow(),
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 12,
                                            color: const Color(0xff999999),
                                            letterSpacing: 0.12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.textfieldColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 2.0,
                                  ),
                                  child: Align(
                                    alignment: isMe
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          visibility[index] == true
                                              ? visibility[index] = false
                                              : visibility[index] = true;
                                        });
                                      },
                                      child: getMessageContainer(
                                          profile.parameters.specificDiscussion
                                              .specificMessage[index],
                                          isMe),
                                    ),
                                  ),
                                ),
                                // if (index != 0 &&
                                //     profile.parameters.specificDiscussion
                                //             .specificMessage[index].sender !=
                                //         profile.parameters.specificDiscussion
                                //             .specificMessage[index - 1].sender)
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: visibility[index],
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                                    child: SizedBox(
                                      child: Text(
                                        profile
                                            .parameters
                                            .specificDiscussion
                                            .specificMessage[index]
                                            .sendTimeMessage,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 12,
                                          color: const Color(0xff999999),
                                          letterSpacing: 0.12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                isTyping
                    ? Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Text(
                          "messages_label_typing".tr(),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 70.0 * screenHeight,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textFieldController,
                          textInputAction: TextInputAction.send,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: "messages_label_typeamessage".tr(),
                            filled: true,
                            fillColor: const Color(0xffebedf0),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.photo_camera),
                              iconSize: 25,
                              color: Colors.grey,
                              onPressed: () async {
                                PickedFile pickedFile =
                                    await ImagePicker().getImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 80,
                                  maxWidth: 400,
                                  maxHeight: 400,
                                );
                                if (pickedFile != null) {
                                  imageFile = File(pickedFile.path);
                                  profile.parameters.location =
                                      'profile.parameters.discussionMails';

                                  profile.parameters.file = imageFile;

                                  SpecificMessage specificMessage =
                                      SpecificMessage(
                                    isFile: true,
                                    message: '',
                                    messageOwnerEmail: profile
                                        .userGeneralInfo.zulipAcces.zulipMail,
                                    messageOwnerName:
                                        profile.userGeneralInfo.firstName,
                                    sendTimeMessage:
                                        DateTime.now().toUtc().toString(),
                                  );
                                  profile.parameters.specificMessage =
                                      specificMessage;
                                  dispatchSendMessage(profile: profile);
                                  profile.parameters.specificMessage = null;
                                }
                              },
                            ),
                            contentPadding: EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.grey[100],
                                )),
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) async {
                            setState(() {});
                            if (value.length > 0) {
                              op = 'stop';
                            } else {
                              op = 'start';
                            }
                            final response = await http.get(
                              "https://foundme-dev.hotline.direct/typing_status?mail=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}&receiver_zulip_mail=${profile.parameters.discussionMails}&op=$op",
                            );
                          },
                          onSubmitted: (value) {
                            if (value.length > 0) {
                              textFieldController.text = '';
                              textFieldController.clear();

                              SpecificMessage specificMessage = SpecificMessage(
                                isFile: false,
                                message: value,
                                messageOwnerEmail: profile
                                    .userGeneralInfo.zulipAcces.zulipMail,
                                messageOwnerName:
                                    profile.userGeneralInfo.firstName,
                                sendTimeMessage:
                                    DateTime.now().toUtc().toString(),
                              );
                              profile.parameters.specificMessage =
                                  specificMessage;
                              setState(() {
                                profile.parameters.specificDiscussion
                                    .specificMessage
                                    .insert(
                                  0,
                                  profile.parameters.specificMessage,
                                );
                                visibility.add(false);
                              });
                              dispatchSendMessage(profile: profile);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5 * screenWidth,
                      ),
                      SizedBox(
                        width: 47 * screenWidth,
                        height: 47 * screenHeight,
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (textFieldController.text.length > 0) {
                              SpecificMessage specificMessage = SpecificMessage(
                                isFile: false,
                                message: textFieldController.text.trim(),
                                messageOwnerEmail: profile
                                    .userGeneralInfo.zulipAcces.zulipMail,
                                messageOwnerName:
                                    profile.userGeneralInfo.firstName,
                                sendTimeMessage:
                                    DateTime.now().toUtc().toString(),
                              );
                              profile.parameters.specificMessage =
                                  specificMessage;
                              textFieldController.text = '';
                              textFieldController.clear();
                              setState(() {
                                profile.parameters.specificDiscussion
                                    .specificMessage
                                    .insert(
                                  0,
                                  profile.parameters.specificMessage,
                                );
                                visibility.add(false);
                              });
                              dispatchSendMessage(profile: profile);
                            } else {
                              _getUserLocation();
                              print(currentPostion);

                              //   _serviceEnabled = await location.serviceEnabled();
                              //   if (!_serviceEnabled) {
                              //     _serviceEnabled =
                              //         await location.requestService();
                              //     if (!_serviceEnabled) {
                              //       return;
                              //     }
                              //   }

                              //   _permissionGranted =
                              //       await location.hasPermission();
                              //   if (_permissionGranted ==
                              //       PermissionStatus.denied) {
                              //     _permissionGranted =
                              //         await location.requestPermission();
                              //     if (_permissionGranted !=
                              //         PermissionStatus.granted) {
                              //       return;
                              //     }
                              //   }

                              //   _locationData = await location.getLocation();

                              profile.parameters.specificMessage =
                                  SpecificMessage(
                                isFile: false,
                                message: "[position]:" +
                                    currentPostion.latitude.toString() +
                                    "," +
                                    currentPostion.longitude.toString(),
                                messageOwnerEmail: profile
                                    .userGeneralInfo.zulipAcces.zulipMail,
                                messageOwnerName:
                                    profile.userGeneralInfo.firstName,
                                sendTimeMessage:
                                    DateTime.now().toUtc().toString(),
                              );
                              setState(() {
                                profile.parameters.specificDiscussion
                                    .specificMessage
                                    .insert(
                                  0,
                                  profile.parameters.specificMessage,
                                );
                              });
                              visibility.add(false);
                              dispatchSendMessage(profile: profile);
                              profile.parameters.specificMessage = null;
                            }
                          },
                          backgroundColor: ColorConstant.pinkColor,
                          child: Icon(
                            textFieldController.text.length == 0
                                ? Icons.location_on
                                : Icons.send,
                            size: 23,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getMessageContainer(SpecificMessage specificMessage, bool isMe) {
    specificMessage.message = specificMessage.message ?? '';
    if (specificMessage.message.startsWith('[link]:')) {
      return Container(
        decoration: isMe
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                color: Color(0xffec1c40),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                  bottomRight: Radius.circular(14.0),
                ),
                color: Color(0xffebebeb),
              ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: InkWell(
                onTap: () async {
                  if (await canLaunch(specificMessage.message
                      .substring(7, specificMessage.message.length))) {
                    await launch(specificMessage.message
                        .substring(7, specificMessage.message.length));
                  }
                },
                child: Text(
                  specificMessage.message
                      .substring(7, specificMessage.message.length),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 14,
                    color: isMe ? Color(0xffffffff) : Color(0xff231f20),
                    letterSpacing: 0.14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            isMe
                ? Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.done_all,
                      color: Colors.white,
                      size: 17,
                    ),
                  )
                : Text(''),
          ],
        ),
      );
    }
    if (specificMessage.message.startsWith('[photo]:')) {
      return Column(
        children: [
          Container(
            width: 230.0 * screenWidth,
            height: 210.0 * screenHeight,
            decoration: isMe
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
                    color: Color(0xffec1c40),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.0),
                      topRight: Radius.circular(14.0),
                      bottomRight: Radius.circular(14.0),
                    ),
                    color: const Color(0xffebebeb),
                  ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Stack(
                children: [
                  Container(
                    width: 224.0 * screenWidth,
                    height: 204.0 * screenHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          specificMessage.message.length > 8
                              ? isMe
                                  ? specificMessage.message
                                          .substring(
                                              8, specificMessage.message.length)
                                          .endsWith('g')
                                      ? specificMessage.message.substring(
                                          8, specificMessage.message.length)
                                      : specificMessage.message.substring(
                                          8, specificMessage.message.length - 1)
                                  : specificMessage.message.substring(
                                      8, specificMessage.message.length)
                              : 'https://www.elegantthemes.com/blog/wp-content/uploads/2018/02/502-error.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: isMe
                    //     ? Text(specificMessage.message
                    //         // .substring(8, specificMessage.message.length),
                    //         )
                    //     : Text(specificMessage.message
                    //         // .substring(8, specificMessage.message.length),
                    //         ),
                  ),
                  isMe
                      ? Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.done_all,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        )
                      : Text('')
                ],
              ),
            ),
          ),
        ],
      );
    } else if (specificMessage.message.startsWith('[position]:')) {
      List<String> latLng = specificMessage.message.split(',');

      final CameraPosition _kGooglePlex = CameraPosition(
        target: LatLng(
          double.parse(latLng[0].substring(11, latLng[0].length)),
          double.parse(latLng[1]),
        ),
        zoom: 14.4746,
      );

      final Set<Marker> _markers = {};
      final markerId = LatLng(
        double.parse(latLng[0].substring(11, latLng[0].length)),
        double.parse(latLng[1]),
      );
      _markers.add(
        Marker(
          markerId: MarkerId(markerId.toString()),
          position: markerId,
        ),
      );

      return Container(
        width: 230.0 * screenWidth,
        height: 210.0 * screenHeight,
        decoration: isMe
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                color: Color(0xffec1c40),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                  bottomRight: Radius.circular(14.0),
                ),
                color: Color(0xffebebeb),
              ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(4),
              child: Container(
                width: 224.0 * screenWidth,
                height: 204.0 * screenHeight,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
            ),
            isMe
                ? Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.done_all,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  )
                : Text('')
          ],
        ),
      );
    } else {
      return Container(
        decoration: isMe
            ? BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0),
                ),
                color: Color(0xffec1c40),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                  bottomRight: Radius.circular(14.0),
                ),
                color: Color(0xffebebeb),
              ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                specificMessage.message,
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 14,
                  color: isMe ? Color(0xffffffff) : Color(0xff231f20),
                  letterSpacing: 0.14,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            isMe
                ? Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(
                      Icons.done_all,
                      color: Colors.white,
                      size: 17,
                    ),
                  )
                : Text(''),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  void dispatchGoToMessages({@required Profile profile}) {
    BlocProvider.of<MessagesBloc>(context).dispatch(
      GoToMessagesEvent(
        profile: profile,
      ),
    );
  }

  void dispatchSendMessage({@required Profile profile}) {
    BlocProvider.of<MessagesBloc>(context).dispatch(
      SendMessageEvent(
        profile: profile,
      ),
    );
  }

  void dispatchMeeting(Profile profile) async {
    final response = await http.get(
      "https://foundme-dev.hotline.direct/create_bigblue?username=${profile.userGeneralInfo.zulipAcces.zulipMail}&nbr_personnes=${profile.parameters.discussionMails.length + 1}",
    );
    if (response.statusCode == 200) {
      final meeting = Meeting.fromJson(json.decode(response.body));
      profile.parameters.specificMessage = SpecificMessage(
        isFile: false,
        isLink: true,
        message: '[link]:' + meeting.getJoinMeetingUrl,
        messageOwnerEmail: profile.userGeneralInfo.zulipAcces.zulipMail,
        messageOwnerName: profile.userGeneralInfo.firstName,
        sendTimeMessage: DateTime.now().toUtc().toString(),
      );
      setState(() {
        profile.parameters.specificDiscussion.specificMessage.insert(
          0,
          profile.parameters.specificMessage,
        );
        visibility.add(false);
      });
      dispatchSendMessage(profile: profile);
    }
  }
}
