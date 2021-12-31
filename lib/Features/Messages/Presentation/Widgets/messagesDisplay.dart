import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';
import 'package:neopolis/Features/Messages/Presentation/bloc/messages_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Messages/Presentation/Widgets/MessagesComponents/item.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class MessagesDisplay extends StatefulWidget {
  final Profile profile;

  MessagesDisplay({Key key, @required this.profile}) : super(key: key);

  @override
  _MessagesDisplayState createState() => _MessagesDisplayState();
}

class _MessagesDisplayState extends State<MessagesDisplay> {
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  int soundId;

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
    // print('InitState LastEventID: ' +
    //     widget.profile.userGeneralInfo.zulipAcces.lastEventId.toString());

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

    // print('Executing API LastEventID: ' +
    //     profile.userGeneralInfo.zulipAcces.lastEventId.toString());

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
    if (response != null) {
      if (response.statusCode == 200) {
        newMessage = NewMessage.fromJson(json.decode(response.body));
        if (newMessage.events != null) {
          if (newMessage.events.last.message != null) {
            if (newMessage.events.last.message.senderEmail !=
                profile.userGeneralInfo.mail) {
              final responseListMessages = await http.get(
                "https://foundme-dev.hotline.direct/get_all_disscussion?username_owner=${profile.userGeneralInfo.zulipAcces.zulipMail}&api_key=${profile.userGeneralInfo.zulipAcces.zulipApiKey}",
              );

              if (mounted) {
                // print('Mounted + SetState');
                await pool.play(soundId);

                setState(() {
                  if (responseListMessages.statusCode == 200) {
                    profile.parameters.discussions = Discussions.fromJson(
                        json.decode(responseListMessages.body));
                  }
                });
              } else {
                // print('Unmounted + NoSetState');
              }
            }
          }
          newMessage = null;
          profile.userGeneralInfo.zulipAcces.lastEventId =
              profile.userGeneralInfo.zulipAcces.lastEventId + 1;
          // print('Incrementing after success 200 LastEventID: ' +
          //     profile.userGeneralInfo.zulipAcces.lastEventId.toString());

          fetchMessages(profile);
        } else {
          profile.userGeneralInfo.zulipAcces.lastEventId =
              profile.userGeneralInfo.zulipAcces.lastEventId + 1;
          // print('Incrementing after success 200 but no messages LastEventID: ' +
          //     profile.userGeneralInfo.zulipAcces.lastEventId.toString());

          fetchMessages(profile);
          return newMessage;
        }
      } else {
        final responseOpenRoom = await http.get(
          "https://foundme-dev.hotline.direct/open_room?",
          headers: {
            'idSession': 'test',
            'username': profile.userGeneralInfo.zulipAcces.zulipMail,
            'api_key': profile.userGeneralInfo.zulipAcces.zulipApiKey,
          },
        );
        if (responseOpenRoom.statusCode == 200) {
          profile.userGeneralInfo.zulipAcces.lastEventId = -1;
          profile.userGeneralInfo.zulipAcces.queueId =
              json.decode(responseOpenRoom.body)['queue_id'];
          // print('LastEventID to -1 fails: ' +
          //     profile.userGeneralInfo.zulipAcces.lastEventId.toString());

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
        // print('LastEventID to -1 fails: ' +
        //     profile.userGeneralInfo.zulipAcces.lastEventId.toString());

        fetchMessages(profile);
      }
    }
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permantly denied, we cannot request permissions.');
  //   }

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {
  //       return Future.error(
  //           'Location permissions are denied (actual value: $permission).');
  //     }
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }
  // _share(){ Share.share('https://www.google.com/maps/search/?api=1&query=${_currentLocation.latitude},${_currentLocation.longitude}'); }

//  _getAddressFromLatLng() async {
//     try {
//       List<Placemark> p = await geolocator.placemarkFromCoordinates(
//           currentPostion.latitude, currentPostion.longitude);

//       Placemark place = p[0];

//       setState(() {
//         _currentAddress =
//             "${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

  @override
  Widget build(BuildContext context) {
    //  _getUserLocation();
    Profile profile = widget.profile;
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    // print(_determinePosition);
    // StreamSubscription<Position> positionStream =
    //     Geolocator.getPositionStream().listen((Position position) {
    //   print(position == null
    //       ? 'Unknown'
    //       : position.latitude.toString() +
    //           ', ' +
    //           position.longitude.toString());
    // });
    //print(positionStream);

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
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
            padding: EdgeInsets.only(top: 58.0 * screenHeight / 2),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: new Center(
                child: new Text(
                  "drawer_label_messages".tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(0xffffffff),
                    letterSpacing: 0.18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    dispatchGoToHome(profile);
                  },
                )
              ],
            ),
          ),
          // Padding(
          //     padding: EdgeInsets.fromLTRB(0, 128 * screenHeight, 0, 0),
          //     child: Container(
          //         height: 400, width: 400, child: _googleMap(context))),
          //      GoogleMap(
          //   markers: _markers,

          //   mapType: _currentMapType,
          //   initialCameraPosition: CameraPosition(
          //     target: _initialPosition,
          //     zoom: 14.4746,
          //   ),
          //   onMapCreated: _onMapCreated,
          //   zoomGesturesEnabled: true,
          //   onCameraMove: _onCameraMove,
          //   myLocationEnabled: true,
          //   compassEnabled: true,
          //   myLocationButtonEnabled: false,

          // ),
          if (profile.parameters.discussions.listMessage != null)
            if (profile.parameters.discussions.listMessage.length != 0)
              Padding(
                padding: EdgeInsets.fromLTRB(0, 128 * screenHeight, 0, 0),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(
                      10 * screenWidth, 10 * screenHeight, 10 * screenWidth, 0),
                  itemCount: profile.parameters.discussions.listMessage.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            profile.parameters.discussionMails = profile
                                .parameters
                                .discussions
                                .listMessage[index]
                                .recievers;
                            profile.parameters.discussionName = profile
                                .parameters
                                .discussions
                                .listMessage[index]
                                .messageOwner;
                            dispatchGoToSpecificMessage(
                              profile: profile,
                            );
                          },
                          child: Item(
                            profile: profile,
                            discussionMails: profile.parameters.discussions
                                .listMessage[index].recievers,
                            discussionsMessage: profile
                                .parameters.discussions.listMessage[index],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }

  void dispatchGoToSpecificMessage({@required Profile profile}) {
    BlocProvider.of<MessagesBloc>(context).dispatch(
      GoToSpecificMessageEvent(
        profile: profile,
      ),
    );
  }

  void dispatchListMessages({@required Profile profile}) {
    BlocProvider.of<MessagesBloc>(context).dispatch(
      GoToMessagesEvent(
        profile: profile,
      ),
    );
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
}
