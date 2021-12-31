import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class ProductPopup extends ModalRoute<void> {
  final Profile profile;

  ProductPopup(this.profile);

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
                  width: screenWidth * 0.95,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 17, bottom: 17, left: 0, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyText(value:
                                "homescree_subtitle_featuredprod".tr(),
                               
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.pinkColor,
                               
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: screenHeight * 0.5,
                              child: GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.5)),
                                itemCount: profile.parameters
                                    .homeParameters['featured_products'].length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      width: screenWidth * 0.5,
                                      height: screenHeight * 0.2,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          /////// tap to see the description of feature product ///////
                                        },
                                        child: Card(
                                          color: ColorConstant.lightGrey,
                                          elevation: 2.3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 65,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      15.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            profile.parameters
                                                                        .homeParameters[
                                                                    'featured_products']
                                                                [index]['data'],
                                                          ),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 35,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    MyText(value:
                                                      profile.parameters
                                                                  .homeParameters[
                                                              'featured_products'][index]
                                                          [
                                                          'featured_product_title'],
                                                     
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize:
                                                              screenWidth *
                                                                      0.05 -
                                                                  6),
                                                   
                                                    SizedBox(
                                                      height:
                                                          screenHeight * 0.005,
                                                    ),
                                                    MyText(value:
                                                      "50\u0024".toUpperCase(),
                                                    
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    
                                                          color: Colors.grey,
                                                          fontSize:
                                                              screenWidth *
                                                                      0.05 -
                                                                  6),
                                                   
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
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
