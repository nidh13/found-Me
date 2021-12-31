import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_tooltip/simple_tooltip.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class AnimatedExamplePage extends StatefulWidget {
  AnimatedExamplePage(Key key, this.content,this.title,this.taped) : super(key: key);

  final String title;
  final String content;
     bool taped;


  @override
  _AnimatedExamplePageState createState() => _AnimatedExamplePageState();
}

class _AnimatedExamplePageState extends State<AnimatedExamplePage> {
  AnimationStatus _marginAnimationStatus;

  int _restartCount = 0;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
     
        SimpleTooltip(
          ballonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        backgroundColor: ColorConstant.textColor,
        borderColor:ColorConstant.textColor,
        //key:_toolTipKey ,
            tooltipTap: () {
            print("Tooltip tap");
            setState(() {
              widget.taped=false;
            });
           

            },
          //  animationDuration: Duration(seconds: 3),
            show:widget.taped,
            tooltipDirection: TooltipDirection.up,
         
            content:
                    Stack(
                      children: [
                   Positioned(right: 0,child:   Image.asset(
                                            "Assets/Images/close-white.png",
                                            color: Colors.white,
                                            height: 9,
                                            width: 9,
                                          
  ),),
  //  Positioned(bottom: 10,child:   Text(
                          
  //                                             'Email Me',
  //                                          style: TextStyle(     decoration:TextDecoration.none ,
  //                                                   fontWeight: FontWeight.w400,
  //                                                   fontSize: 14,
  //                                                   color: ColorConstant.whiteTextColor,
  //                                                   ),
  //                                                       softWrap: true,

                                          
  // ),),
                     Text.rich(TextSpan(
                                      text:  ' '+ '\n' ,
                                        style: TextStyle(
                                            fontFamily: 'SFProText',
                                            fontWeight: FontWeight.w500,
                                            decoration:TextDecoration.none ,
                                            fontSize: 10,
                                            color: ColorConstant.colorBlockVide),
                                        children: <InlineSpan>[
                                          TextSpan(
                                        text:widget.title +' '+ '\n' ,
                                        style: TextStyle(
                                            fontFamily: 'SFProText',
                                            fontWeight: FontWeight.w500,
                                            decoration:TextDecoration.none ,
                                            fontSize: 14,
                                            color: ColorConstant.colorBlockVide)),
                                         WidgetSpan(
                                           child: Container(height: 8,),
                                     ),
                                         TextSpan(
                                        text:widget.content,
                                        style: TextStyle(
                                            fontFamily: 'SFProText',
                                            fontWeight: FontWeight.w400,
                                            decoration:TextDecoration.none ,
                                            fontSize: 12,
                                            color: ColorConstant.colorBlockVide),)
                                        ])),],
                    ),
        
                   
                                       
             
          //    MyText(
          // value:title,
            
          //       color: Colors.white,
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       decoration: TextDecoration.none,
           
          //   ),
        
                                  //          },
                                             
                                              child: 
                                              // SimpleTooltip(
                                              //     key: GlobalKey(),
                                              //     tooltipTap: () {
                                              //       print("Tooltip tap");
                                              //     },
                                              //     // animationDuration: Duration(seconds: 3),
                                              //     show:taped,
                                              //     backgroundColor: Colors.black,
                                              //     tooltipDirection: TooltipDirection.up,
                                              //     child: 
                                                  CircleAvatar(
                                                                                                      child: Image.asset(
                                                      "Assets/Images/info.png",
                                                      height: 14,
                                                      width: 14,
                                                    ),
                                                  ),
                                                  // content: Text(
                                                  //   "Some",
                                                  //   style: TextStyle(
                                                  //     color: Colors.white,
                                                  //     fontSize: 18,
                                                  //     decoration: TextDecoration.none,
                                                  //   ),
                                                  // )),
                                        
  ),
    
  
                                    
      ],
    );
   
  }
}

class MarginTransition extends StatefulWidget {
  final Widget child;
  final Widget Function(BuildContext, double margin, Widget child) builder;
  final ValueChanged<AnimationStatus> animationStatusChange;

  MarginTransition({
    Key key,
    @required this.child,
    @required this.builder,
    this.animationStatusChange,
  })  : assert(builder != null),
        super(key: key);

  @override
  _MarginTransitionState createState() => _MarginTransitionState();
}

class _MarginTransitionState extends State<MarginTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationController.forward();
    _animation =
        Tween<double>(begin: 10, end: 300).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }

            if (widget.animationStatusChange != null) {
              widget.animationStatusChange(_animationController.status);
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        return widget.builder(context, _animation.value, child);
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
