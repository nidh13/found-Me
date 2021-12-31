import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/PopupTagsDisplay.Dart';
import 'package:neopolis/Core/Utils/text.dart';

class ExpandableUserList extends StatefulWidget {
  final Profile profil;
  final int index;
  final String type;
  final String itemTitle;
  final String itemCode;
  final String itemImage;

  final bool isMedicalIcon;
  final bool isRewardIcon;
  final bool isAttachIcon;
  final bool isAlarmIcon;

  ExpandableUserList({
    Key key,
    this.profil,
    this.index,
    this.type,
    this.itemTitle,
    this.itemCode,
    this.itemImage,
    this.isMedicalIcon,
    this.isRewardIcon,
    this.isAttachIcon,
    this.isAlarmIcon,
  });

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableUserList> {
  bool expandFlag = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 45, right: 11),
      child: Container(
        height: 48,
        child: Row(
          children: [
            InkWell(
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: ColorConstant.imgBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: NetworkImage(widget.itemImage),
                        fit: BoxFit.cover)),
              ),
              onTap: () {

  /*               Navigator.of(context).push(PopUpTagsDisplay(widget.profil,widget.index,widget.itemImage, widget.type)); */
              },
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(value:
                      widget.itemTitle ?? " ",
                   
                          color: ColorConstant.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                   
                    MyText(value:
                      widget.itemCode,
                     
                          color: ColorConstant.switchTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                   
                  ],
                ),
                onTap: () {
             

               /*    dispatchgettoSwitchObjectTag(
                      widget.profil, widget.index, widget.type); */
                },
              ),
            ),
            Row(
              children: [
                widget.isMedicalIcon
                    ? Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Image.asset(
                          "Assets/Images/Medical.png",
                          height: 16.7,
                          width: 16,
                        ),
                      )
                    : Container(),
                widget.isAttachIcon
                    ? Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Image.asset(
                          "Assets/Images/attachment-green.png",
                          height: 16,
                          width: 16,
                        ),
                      )
                   
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

 /*  dispatchgettoSwitchObjectTag(Profile profile, int index, String type) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoTogetSwitchObjectTagEvent(
        profile: profile,
        index: index,
        type: type,
      ),
    );
  } */
}
