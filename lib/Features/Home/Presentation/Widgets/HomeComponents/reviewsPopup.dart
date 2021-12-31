import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class ReviewsPopup extends ModalRoute<void> {
  final Profile profile;

  ReviewsPopup(this.profile);

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
                            MyText(value:
                              "homescree_subtitle_reviews".tr(),
                            
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
                                      .homeParameters['reviews'].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (profile.parameters
                                                .homeParameters['reviews']
                                            [index]['active'] ==
                                        1)
                                      return Container(
                                        height: screenHeight * 0.25,
                                        child: InkWell(
                                          onTap: () {
                                            /////// tap to see customer reviews ////////
                                          },
                                          child: Card(
                                            color: Colors.white,
                                            elevation: 2.3,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                side: BorderSide(
                                                    width: 0.1,
                                                    color: Colors.black26)),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: screenWidth * 0.7,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 77,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: ColorConstant
                                                            .lightGrey,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  15.0),
                                                        ),
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding: EdgeInsets.only(
                                                          top: screenHeight *
                                                              0.01,
                                                          left: screenWidth *
                                                              0.02,
                                                          right: screenWidth *
                                                              0.02),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: MyText(value:
                                                              profile.parameters
                                                                          .homeParameters[
                                                                      'reviews']
                                                                  [
                                                                  index]['client'],
                                                             
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                             
                                                                  color: ColorConstant
                                                                      .pinkColor,
                                                                  fontSize:
                                                                      screenWidth *
                                                                              0.05 -
                                                                          6),
                                                           
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: screenHeight *
                                                                          0.01),
                                                              child: MyText(value:
                                                                profile.parameters
                                                                            .homeParameters[
                                                                        'reviews'][index]
                                                                    [
                                                                    'reviews_title'],
                                                             
                                                                maxLines: 5,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                               
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        screenWidth *
                                                                                0.05 -
                                                                            6),
                                                             
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 23,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  screenWidth *
                                                                      0.02),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          MyText(value:
                                                            profile
                                                                    .parameters
                                                                    .homeParameters[
                                                                        'reviews']
                                                                        [index]
                                                                        ['rank']
                                                                    .toString() +
                                                                "/5",
                                                          
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    screenWidth *
                                                                            0.05 -
                                                                        6),
                                                         
                                                          Container(
                                                            child: RatingBar(
                                                              initialRating: profile
                                                                          .parameters
                                                                          .homeParameters[
                                                                      'reviews']
                                                                  [
                                                                  index]['rank'],
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemSize:
                                                                  screenWidth *
                                                                          0.1 -
                                                                      10,
                                                              itemCount: 5,
                                                              ratingWidget:
                                                                  RatingWidget(
                                                                full: Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 5.0,
                                                                ),
                                                                half: Icon(
                                                                  Icons
                                                                      .star_half,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 5.0,
                                                                ),
                                                                empty: Icon(
                                                                  Icons
                                                                      .star_border,
                                                                  color: Colors
                                                                      .yellow,
                                                                  size: 5.0,
                                                                ),
                                                              ),
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          1.0),
                                                              ignoreGestures:
                                                                  true,
                                                              onRatingUpdate:
                                                                  (rating) {},
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
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
