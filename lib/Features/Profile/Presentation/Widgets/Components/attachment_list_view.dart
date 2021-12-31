import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class AttachmentListView extends StatefulWidget {
  final String image;
  String title;
  bool switchValue;
  final visibileAttachments;

  AttachmentListView(
      {this.image, this.title, this.switchValue, this.visibileAttachments});

  @override
  AttachmentListViewState createState() => new AttachmentListViewState();
}

class AttachmentListViewState extends State<AttachmentListView> {
  String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(bottom: 6.0),
      // padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.image != null
              ? widget.image.contains(
                        '.pdf',
                      ) ==
                      false
                  ? InkWell(
                      onTap: () async {
                        url = widget.image;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            color: ColorConstant.imgBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                                image: NetworkImage(widget.image),
                                fit: BoxFit.cover)),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        url = widget.image;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                              color: ColorConstant.imgBackgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://nlmt.fr/wp-content/uploads/2016/11/fichier.png'),
                                  fit: BoxFit.cover))),
                    )
              : Container(),
          SizedBox(
            width: 13,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: widget.title != null
                        ? Text(
                            widget.title,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 12,
                                color: ColorConstant.textColor,
                                fontWeight: FontWeight.w500),
                            softWrap: true,
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: MyTextField(
                              initialValue: '',
                              inputType: TextInputType.multiline,
                              focusNode: null,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              onChanged: (value) {
                                widget.title = value;
                              },
                            ),
                          ),
                  ),
                  widget.switchValue
                      ? widget.visibileAttachments != null
                          ? Visibility(
                              visible: !widget.visibileAttachments,
                              child: Image.asset(
                                "Assets/Images/eye-green.png",
                                height: 12,
                                width: 17.85,
                              ))
                          : Container()
                      : widget.visibileAttachments != null
                          ? Visibility(
                              visible: !widget.visibileAttachments,
                              child: Image.asset(
                                "Assets/Images/eye-close.png",
                                height: 16,
                                width: 20,
                              ))
                          : Container(),
                  SizedBox(
                    width: 13,
                  ),
                  widget.visibileAttachments != null
                      ? Visibility(
                          visible: !widget.visibileAttachments,
                          child: CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: widget.switchValue,
                            onChanged: (value) {
                              setState(() {
                                widget.switchValue = value;
                              });
                            },
                          ),
                        )
                      : Container(),
                  widget.visibileAttachments != null
                      ? Visibility(
                          visible: widget.visibileAttachments,
                          child: Material(
                              // pause button (round)
                              borderRadius: BorderRadius.circular(
                                  50), // change radius size
                              color: Colors.red, //button colour
                              child: InkWell(
                                  splashColor:
                                      Colors.red, // inkwell onPress colour
                                  child: SizedBox(
                                      width: 24,
                                      height:
                                          24, //customisable size of 'button'
                                      child: Center(
                                          child: FaIcon(
                                        FontAwesomeIcons.minus,
                                        color: Colors.white,
                                        size: 16,
                                      ))
                                      /*Icon(Icons.delete, )*/
                                      ),
                                  onTap: () {
                                    setState(() {
                                      print("value of visible ");
                                    });
                                  })))
                      : Container(),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //Container(height: 10,width: 10,color: Colors.red,)
                  widget.visibileAttachments != null
                      ? Visibility(
                          visible: !widget.visibileAttachments,
                          child: Text(
                            widget.switchValue
                                ? "objecttag_label_public".tr()
                                : "objecttag_label_private".tr(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 7,
                                color: ColorConstant.switchTextColor,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: 11,
                  )
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
