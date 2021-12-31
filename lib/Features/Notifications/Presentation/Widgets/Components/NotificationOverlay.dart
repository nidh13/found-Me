import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class InAppNotificationOverlay extends ModalRoute<void> {
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

  List<Marker> allMarkers = [];
  GoogleMapController _controller;
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
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    //  permissionNames.add(PermissionName.Location);
/*   allMarkers.add(
      Marker(infoWindow: InfoWindow(title: "dubai", snippet: "dubai abudhabi",),
        markerId: MarkerId("mu marker"),
        draggable: false,
        icon:   BitmapDescriptor.defaultMarker,
        onTap: () {
          print("my dada");
        },
        position: LatLng(25.2048, 55.2708),
      ),
    );  */
    allMarkers.add(
      Marker(
        infoWindow: InfoWindow(
          title: "dubai",
          snippet: "dubai abudhabi",
        ),
        markerId: MarkerId("mu marker"),
        draggable: false,
        icon: BitmapDescriptor.fromAsset("Assets/Images/location-red.png"),
        onTap: () {
          print("my dada");
        },
        position: LatLng(33.852, 151.211),
      ),
    );

    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
//            height: screenHeight * 1.0,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: Container(
                          child:
                              Image.asset("Assets/Images/pablo-searching.png"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.04,
                            right: screenWidth * 0.04),
                        child: Text(
                          "notifications_label_itemnf".tr(),
                          style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: ColorConstant.redColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.08,
                            right: screenWidth * 0.08),
                        child: Text(
                          "Septmber 9, 2020 09.20 PM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorConstant.greyColor,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(
                            bottom: 30,
                            left: 18,
                            right: screenWidth * 0.08,
                            top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: ColorConstant.greyColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.01 / 100),
                                  child: Text(
                                    "Hardisk 1TB",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 13),
                                  child: Text(
                                    "Steve - Electronics\nCODE-1234",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ColorConstant.greyColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: screenHeight * 0.025),
                                  child: Image.asset(
                                    "Assets/Images/rewards.png",
                                    height: screenWidth * 0.1 + 5,
                                    width: screenWidth * 0.1 + 5,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 148,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(25.2048, 55.2708),
                            zoom: 14.151926040649414,
                          ),
                          markers: Set.from(allMarkers),
                          tiltGesturesEnabled: false,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: false,
                          onMapCreated: mapCreated,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              height: 52,
                              child: RaisedButton(
                                textColor: ColorConstant.whiteTextColor,
                                child: Text("Not Available",
                                    style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white)),
                                color: ColorConstant.redColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.0),
                                )),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 52,
                              child: RaisedButton(
                                textColor: ColorConstant.whiteTextColor,
                                child: Text("Start Chat",
                                    style: TextStyle(
                                        fontFamily: 'SourceSansPro',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.white)),
                                color: ColorConstant.greenColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                )),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*child: Stack(
                              fit: StackFit.expand,
                              children: [

                                Container(width: double.maxFinite,decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0),)
                                ),),
                                Positioned(
                                top:screenHeight*0.153 ,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    child:
                                  ),
                                )
                              ],
                            ),*/
                      //   )
                    ],
                  ),
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
                        image: AssetImage("Assets/Images/close.png"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void mapCreated(controller) {
    setState(() {
/*       _controller = controller; */
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
