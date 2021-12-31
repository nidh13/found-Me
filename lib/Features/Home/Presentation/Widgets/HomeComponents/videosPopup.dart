import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:better_player/better_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class VideosPopup extends ModalRoute<void> {
  final Profile profile;

  VideosPopup(this.profile);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  double screenWidth;
  double screenHeight;

  List nameList = ['Df', 'Vb'];
  var nameData;
  YoutubePlayerController _controller;
  String getVideoID(String url) {
    int index;
    index = url.indexOf('=');
    url = url.replaceRange(0, index + 1, '');
    index = url.indexOf('&');
    url = url.replaceRange(index, url.length, '');
    return url;
  }

  final ScrollController nameScroll = ScrollController();
  List<String> name = ["g", "f", "h", "e", "t"];
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context, profile),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, Profile profile) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (Orientation.portrait == orientation) {
          screenWidth = MediaQuery.of(context).size.width;
          screenHeight = MediaQuery.of(context).size.height;
        } else {
          screenWidth = MediaQuery.of(context).size.height;
          screenHeight = MediaQuery.of(context).size.width;
        }

        return Container(
            height: screenHeight * 1.0,
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  width: screenWidth * 0.85,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 17, bottom: 17, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(value:
                              "homescree_subtitle_videos".tr(),
                             
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
   color: ColorConstant.pinkColor,                              ),
                            
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: screenHeight * 0.5,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: profile.parameters
                                      .homeParameters['videos'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (profile.parameters
                                        .homeParameters['videos'][index]['link']
                                        .contains('youtube')) {
                                      _controller = YoutubePlayerController(
                                        initialVideoId: getVideoID(
                                          profile.parameters
                                                  .homeParameters['videos']
                                              [index]['link'],
                                        ),
                                        flags: YoutubePlayerFlags(
                                          controlsVisibleAtStart: true,
                                          disableDragSeek: true,
                                          hideControls: false,
                                          autoPlay: false,
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 0, right: 0, bottom: 20),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          width: screenWidth * 0.85,
                                          alignment: Alignment.centerLeft,
                                          child: profile
                                                  .parameters
                                                  .homeParameters['videos']
                                                      [index]['link']
                                                  .contains('youtube')
                                              ? Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    YoutubePlayer(
                                                      controller: _controller,
                                                      aspectRatio: 16 / 9,
                                                      // thumbnail: Container(
                                                      //   decoration: BoxDecoration(
                                                      //     image: DecorationImage(
                                                      //       image: NetworkImage(
                                                      //         profile.parameters
                                                      //                     .homeParameters[
                                                      //                 'videos'][index]
                                                      //             ['data'],
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ),
                                                  ],
                                                )
                                              : Container(
                                                  child: AspectRatio(
                                                    aspectRatio: 16 / 9,
                                                    child: BetterPlayer.network(
                                                      profile.parameters
                                                                  .homeParameters[
                                                              'videos'][index]
                                                          ['link'],
                                                      betterPlayerConfiguration:
                                                          BetterPlayerConfiguration(
                                                        controlsConfiguration:
                                                            BetterPlayerControlsConfiguration(
                                                          enableFullscreen:
                                                              true,
                                                          enablePlayPause: true,
                                                          showControlsOnInitialize:
                                                              false,
                                                        ),
                                                        autoPlay: false,
                                                        fullScreenByDefault:
                                                            true,
                                                        aspectRatio: 16 / 9,
                                                        allowedScreenSleep:
                                                            false,
                                                        placeholder:
                                                            Image.network(
                                                          profile.parameters
                                                                      .homeParameters[
                                                                  'videos']
                                                              [index]['data'],
                                                        ),
                                                        showPlaceholderUntilPlay:
                                                            true,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("Assets/Images/close.png"))),
                    ),
                  ),
                )
              ],
            )));
      },
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  viewFisrtNameLastNameMember(String first, String last) {
    if (first != null && last == null) {
      return MyText(value:
        first,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
          color: ColorConstant.pinkColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
      
      );
    }
    if (first == null && last != null) {
      return MyText(value:
        last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
       
          color: ColorConstant.pinkColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
       
      );
    }
    if (first == null && last == null) {
      return MyText(value:
        ' ',
        maxLines: 1,
        
        overflow: TextOverflow.ellipsis,
      
          color: ColorConstant.pinkColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
       
      );
    }
    if (first != null && last != null) {
      return MyText(value:
        first + ' ' + last,
        maxLines: 1,
    
        overflow: TextOverflow.ellipsis,
  
          color: ColorConstant.pinkColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
       
      );
    }
  }
}
