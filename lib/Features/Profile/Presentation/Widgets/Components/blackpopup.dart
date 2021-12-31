library popup_menu;

import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'triangle_painter.dart';
import 'package:neopolis/Core/Utils/text.dart';

import 'package:easy_localization/easy_localization.dart';

abstract class MenuItemProviderP {
  Widget get menuImage;
  TextStyle get menuTextStyle;
  String type;
}

class MenuItemP extends MenuItemProviderP {
  Widget image;
  String type;
  var userInfo;
  TextStyle textStyle;

  MenuItemP({this.image, this.type, this.userInfo, this.textStyle});

  @override
  Widget get menuImage => image;

  @override
  TextStyle get menuTextStyle =>
      textStyle ?? TextStyle(color: Color(0xffc5c5c5), fontSize: 10.0);
}

enum MenuType { big, oneLine }

typedef MenuClickCallbackP = Function(MenuItemProviderP item);
typedef PopupMenuStateChangedP = Function(bool isShow);

class PopupMenuP {
  static var itemWidth = 72.0;
  static var itemHeight = 65.0;
  static var arrowHeight = 10.0;
  OverlayEntry _entry;
  List<MenuItemProviderP> items;

  /// row count
  int _row;

  /// col count
  int _col;

  /// The left top point of this menu.
  Offset _offset;

  /// Menu will show at above or under this rect
  Rect _showRect;

  /// if false menu is show above of the widget, otherwise menu is show under the widget
  bool _isDown = true;

  /// The max column count, default is 4.
  int _maxColumn;

  /// callback
  VoidCallback dismissCallback;
  MenuClickCallbackP onClickMenu;
  PopupMenuStateChangedP stateChanged;

  String titre;
  String content;

  Size _screenSize;

  /// Cannot be null
  static BuildContext context;

  /// style
  Color _backgroundColor;
  Color _highlightColor;
  Color _lineColor;

  /// It's showing or not.
  bool _isShow = false;
  bool get isShow => _isShow;

  PopupMenuP(
      {MenuClickCallbackP onClickMenu,
      BuildContext context,
      VoidCallback onDismiss,
      int maxColumn,
      String titre,
      String content,
      Color backgroundColor,
      Color highlightColor,
      Color lineColor,
      PopupMenuStateChangedP stateChanged,
      List<MenuItemProviderP> items}) {
    this.onClickMenu = onClickMenu;
    this.dismissCallback = onDismiss;
    this.stateChanged = stateChanged;
    this.items = items;
    this.titre = titre;
    this.content = content;
    this._maxColumn = maxColumn ?? 4;
    this._backgroundColor = backgroundColor ?? Color(0xff232323);
    this._lineColor = lineColor ?? Color(0xff353535);
    this._highlightColor = highlightColor ?? Color(0x55000000);
    if (context != null) {
      PopupMenuP.context = context;
    }
  }

  void showP({Rect rect, GlobalKey widgetKey, List<MenuItemProviderP> items}) {
    if (rect == null && widgetKey == null) {
      print("'rect' and 'key' can't be both null");
      return;
    }

    this.items = items ?? this.items;
    this._showRect = rect ?? PopupMenuP.getWidgetGlobalRect(widgetKey);
    this._screenSize = window.physicalSize / window.devicePixelRatio;
    this.dismissCallback = dismissCallback;

    _calculatePosition(PopupMenuP.context);

    _entry = OverlayEntry(builder: (context) {
      return buildPopupMenuLayout(_offset);
    });

    Overlay.of(PopupMenuP.context).insert(_entry);
    _isShow = true;
    if (this.stateChanged != null) {
      this.stateChanged(true);
    }
  }

  static Rect getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  void _calculatePosition(BuildContext context) {
    _col = _calculateColCount();
    _row = _calculateRowCount();
    _offset = _calculateOffset(PopupMenuP.context);
  }

  Offset _calculateOffset(BuildContext context) {
    double dx = _showRect.left + _showRect.width / 2.0 - menuWidth() / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + menuWidth() > _screenSize.width && dx > 10.0) {
      double tempDx = _screenSize.width - menuWidth() - 10;
      if (tempDx > 10) dx = tempDx;
    }

    double dy = _showRect.top - menuHeight();
    if (dy <= MediaQuery.of(context).padding.top + 10) {
      // The have not enough space above, show menu under the widget.
      dy = arrowHeight + _showRect.height + _showRect.top;
      _isDown = false;
    } else {
      dy -= arrowHeight;
      _isDown = true;
    }

    return Offset(dx, dy);
  }

  double menuWidth() {
    return MediaQuery.of(context).size.width * .90;
  }

  // This height exclude the arrow
  double menuHeight() {
    return 70;
  }

  LayoutBuilder buildPopupMenuLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
//        onTapDown: (TapDownDetails details) {
//          dismiss();
//        },
        // onPanStart: (DragStartDetails details) {
        //   dismiss();
        // },
        onVerticalDragStart: (DragStartDetails details) {
          dismiss();
        },
        onHorizontalDragStart: (DragStartDetails details) {
          dismiss();
        },
        child: Container(
          margin: EdgeInsets.only(right: 0),
          child: Stack(
            children: <Widget>[
              // triangle arrow
              Positioned(
                left: _showRect.left + _showRect.width / 4 - 3.5,
                top: _isDown
                    ? offset.dy + menuHeight()
                    : offset.dy - arrowHeight,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    size: Size(15.0, arrowHeight),
                    painter: TrianglePainter(
                      isDown: _isDown,
                      color: ColorConstant.textColor,
                    ),
                  ),
                ),
              ),
              // menu content
              Positioned(
                left: offset.dx ,
                top: offset.dy + 12,
                child: Container(
                  padding: EdgeInsets.only(right: 18),
                  width: menuWidth(),
                  height: menuHeight(),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 9.5, left: 12, right: 12),
                            width: MediaQuery.of(context).size.width * .90,
                            //height: 103,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                color: ColorConstant.textColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: [
                                Container(
                                  height: 16.5,
                                  child: Row(
                                    children: [
                                    
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: MyText(value:titre,
                                            
                                                
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: ColorConstant
                                                      .whiteTextColor),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Image.asset(
                                          "Assets/Images/close-white.png",
                                          height: 9,
                                          width: 9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                               Padding(
                                 padding: const EdgeInsets.only(bottom:8.0),
                                 child: Align(
                                                                        alignment: Alignment.bottomLeft,

                                                                    child: MyText(value:
                                      content,
                                    
                                          fontSize: 10,
                                         // fontFamily: 'SourceSansPro',
                                          color: ColorConstant.whiteTextColor,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.none,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 20, // removes yellow line
                                    ),
                                 ),
                               ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }





  // calculate row count
  int _calculateRowCount() {
    if (items == null || items.length == 0) {
      debugPrint('error menu items can not be null');
      return 0;
    }

    int itemCount = items.length;

    if (_calculateColCount() == 1) {
      return itemCount;
    }

    int row = (itemCount - 1) ~/ _calculateColCount() + 1;

    return row;
  }

  // calculate col count
  int _calculateColCount() {
    if (items == null || items.length == 0) {
      debugPrint('error menu items can not be null');
      return 0;
    }

    int itemCount = items.length;
    if (_maxColumn != 4 && _maxColumn > 0) {
      return _maxColumn;
    }

    if (itemCount == 4) {
      return 2;
    }

    if (itemCount <= _maxColumn) {
      return itemCount;
    }

    if (itemCount == 5) {
      return 3;
    }

    if (itemCount == 6) {
      return 3;
    }

    return _maxColumn;
  }

  double get screenWidth {
    double width = window.physicalSize.width;
    double ratio = window.devicePixelRatio;
    return width / ratio;
  }


  void itemClicked(MenuItemProviderP item) {
    if (onClickMenu != null) {
      onClickMenu(item);
    }

    dismiss();
  }

  void dismiss() {
    if (!_isShow) {
      // Remove method should only be called once
      return;
    }

    _entry.remove();
    _isShow = false;
    if (dismissCallback != null) {
      dismissCallback();
    }

    if (this.stateChanged != null) {
      this.stateChanged(false);
    }
  }
}


