import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpImage extends ModalRoute<void> {
  final String picture;

  PopUpImage(this.picture);

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
        child: _buildOverlayContent(context, picture),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, String picture) {
    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(20.0),
          width: screenWidth * 0.85,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: (screenWidth * 110.34) / 100,
                          height: (screenWidth * 110.34) / 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                picture,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8,
                                bottom: 1,
                                left: screenWidth * 0.78,
                                right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 12, left: 4, right: 5, bottom: 9),
                                    child: Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        "Assets/Images/close-white.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
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
}
