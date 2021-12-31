import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class TagExpansionTileItem extends StatefulWidget {
  const TagExpansionTileItem({
    Key key,
    @required this.title,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.type,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final String title;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool> onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  final String type;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  @override
  _TagExpansionTileItemState createState() => _TagExpansionTileItemState();
}

class _TagExpansionTileItemState extends State<TagExpansionTileItem>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _borderColor;
  Animation<Color> _headerColor;
  Animation<Color> _iconColor;
  Animation<Color> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final Color borderSideColor = _borderColor.value ?? Colors.transparent;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: _handleTap,
          child: Container(
              constraints: BoxConstraints(minHeight: 55.0),
              height: 72,
              decoration: BoxDecoration(
                color: _isExpanded
                    ? ColorConstant.pinkColor
                    : ColorConstant.boxColor,
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                    spreadRadius: 0.01,
                  ),
                ],
              ),
              padding: EdgeInsets.only(right: 10),
              margin: EdgeInsets.only(bottom: 5.0),
              child: Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(
                      color: _isExpanded
                          ? _iconColor.value
                          : ColorConstant.pinkColor),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(9),
                              bottomLeft: Radius.circular(9))),
                      width: 96,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.type == "medical"
                              ? Image.asset("Assets/Images/Medical.png",
                                  color: ColorConstant.pinkColor,
                                  height: 47,
                                  width: 47)
                              : widget.type == "Object"
                                  ? Image.asset("Assets/Images/Objects.png",
                                      color: ColorConstant.pinkColor,
                                      height: 47,
                                      width: 47)
                                  : widget.type == "pet"
                                      ? Image.asset("Assets/Images/Pets.png",
                                          color: ColorConstant.pinkColor,
                                          height: 47,
                                          width: 47)
                                      : Image.asset("Assets/Images/Pets.png",
                                          color: ColorConstant.pinkColor,
                                          height: 47,
                                          width: 47),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          height: double.maxFinite,
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.title,
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: _isExpanded
                                    ? Colors.white
                                    : ColorConstant.textColor),
                          )),
                    ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: const Icon(Icons.expand_more),
                    ),
                  ],
                ),
              )),
        ),
        ClipRect(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = theme.textTheme.subtitle1.color
      ..end = theme.accentColor;
    _iconColorTween
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
