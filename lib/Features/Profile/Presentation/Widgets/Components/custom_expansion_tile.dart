// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Duration _kExpand = Duration(milliseconds: 200);

/// A single-line [ListTile] with a trailing button that expands or collapses
/// the tile to reveal or hide the [children].
///
/// This widget is typically used with [ListView] to create an
/// "expand / collapse" list entry. When used with scrolling widgets like
/// [ListView], a unique [PageStorageKey] must be specified to enable the
/// [ExpansionTile] to save and restore its expanded state when it is scrolled
/// in and out of view.
///
/// See also:
///
///  * [ListTile], useful for creating expansion tile [children] when the
///    expansion tile represents a sublist.
///  * The "Expand/collapse" section of
///    <https://material.io/guidelines/components/lists-controls.html>.
class ExpansionTile extends StatefulWidget {
  /// Creates a single-line [ListTile] with a trailing button that expands or collapses
  /// the tile to reveal or hide the [children]. The [initiallyExpanded] property must
  /// be non-null.
  const ExpansionTile({
    Key key,
    this.leading,
    @required this.title,
    this.subtitle,
    this.borderRadius,
    this.headerDecoration,
    this.headerOpenDecoration,
    this.headerPadding,
    this.headerMargin,
    this.headerHeight,
    this.headerMinHeight,
    this.selectedIconColor,
    this.backgroundDecoration,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget subtitle;

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

  /// A widget to display instead of a rotating arrow icon.
  final Widget trailing;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  final BorderRadius borderRadius;

  /// The decoration to display the background of the header.
  final Decoration headerDecoration;

  /// The decoration to display the background of the header.
  final Decoration headerOpenDecoration;

  /// The decoration to display the background of the header.
  final Color selectedIconColor;

  /// The decoration to display the background of the header.
  final EdgeInsets headerPadding;

  /// The decoration to display the background of the header.
  final EdgeInsets headerMargin;

  /// The decoration to display the background of the header.
  final double headerHeight;

  /// The decoration to display the background of the header.
  final double headerMinHeight;

  /// The decoration to display the background of the content.
  final Decoration backgroundDecoration;

  @override
  _ExpansionTileState createState() => _ExpansionTileState();
}

class _ExpansionTileState extends State<ExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;
  Animation<Color> _iconColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InkWell(
          onTap: _handleTap,
          child: Container(
              constraints:
                  BoxConstraints(minHeight: widget.headerMinHeight ?? 36.0),
              height: widget.headerHeight,
              decoration: _isExpanded
                  ? widget.headerOpenDecoration ?? widget.headerDecoration
                  : widget.headerDecoration,
              padding: widget.headerPadding ??
                  EdgeInsets.symmetric(horizontal: 10.0),
              margin: widget.headerMargin ?? EdgeInsets.all(0.0),
              child: Theme(
                data: ThemeData(
                  iconTheme: IconThemeData(
                      color: _isExpanded
                          ? _iconColor.value
                          : widget.selectedIconColor ?? _iconColor.value),
                ),
                child: Row(
                  children: <Widget>[
                    widget.leading ?? Container(),
                    Expanded(child: widget.title),
                    widget.trailing ??
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
            decoration: widget.backgroundDecoration,
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
