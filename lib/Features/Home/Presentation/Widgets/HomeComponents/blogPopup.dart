import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class BlogPopup extends ModalRoute<void> {
  final Profile profile;

  BlogPopup(this.profile);

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
                            MyText(
                              value: "homescree_subtitle_blog".tr(),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.pinkColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: screenHeight * 0.5,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: profile.parameters
                                      .homeParameters['blogs'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        height: screenHeight * 0.25,
                                        child: InkWell(
                                          onTap: () async {
                                            await launch(profile.parameters
                                                    .homeParameters['blogs']
                                                [index]['link']);
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight:
                                                    Radius.circular(10.0)),
                                            child: Container(
                                              width: screenWidth * 0.80,
                                              margin: EdgeInsets.only(
                                                  right:
                                                      screenWidth * 0.05 / 3),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: screenWidth * 0.80,
                                                    height: screenHeight * 0.24,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          profile.parameters
                                                                      .homeParameters[
                                                                  'blogs']
                                                              [index]['data'],
                                                        ),
                                                        fit: BoxFit.cover,
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                          Colors.black
                                                              .withOpacity(0.2),
                                                          BlendMode.darken,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5,
                                                          left: 5.0,
                                                          right: 5.0,
                                                          bottom: 1.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: MyText(
                                                                value: profile
                                                                        .parameters
                                                                        .homeParameters['blogs'][index]
                                                                    [
                                                                    'blogs_title'],
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.03,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              /////// tap to read more ////////
                                                            },
                                                            child: MyText(
                                                                value: "homescree_href_readmore"
                                                                        .tr() +
                                                                    ">",
                                                                color: ColorConstant
                                                                    .pinkColor,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.03),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                    return Container();
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
      return MyText(
        value: first,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
    if (first == null && last != null) {
      return MyText(
        value: last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
    if (first == null && last == null) {
      return MyText(
        value: ' ',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
    if (first != null && last != null) {
      return MyText(
        value: first + ' ' + last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
      );
    }
  }
}
