import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class MyTextField extends StatelessWidget {
  Key key;
  final String initialValue;
  final String iconData;
  final double height;
  final IconButton suffixIcon;
  final String title;
  final double paddingVertical;
  final double paddingHorizontal;
  final TextEditingController textController;
  final Color editTextBgColor;
  final Color hintTextColor;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final String errorText;
  final TextInputType inputType;
  final bool enabled;
  final int maxline;
  final double width;
  final keyboardType;
  final InputDecoration decoration;
  final bool obscureText;
  ValueChanged onChanged;
  ValueChanged onFieledSubmit;
  FormFieldValidator validator;
  final String hintText;
  MyTextField({
    this.initialValue,
    this.key,
    this.iconData,
    this.height,
    this.focusNode,
    this.maxline,
    this.width,
    this.keyboardType,
    this.paddingVertical,
    this.paddingHorizontal,
    this.title,
    this.enabled,
    this.validator,
    this.obscureText = false,
    this.textController,
    this.editTextBgColor,
    this.onFieledSubmit,
    this.hintTextColor,
    this.suffixIcon,
    this.decoration,
    this.errorText,
    this.onChanged,
    this.textInputAction,
    this.hintText,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return
//      crossAxisAlignment: CrossAxisAlignment.start,

        Container(
            width: width ?? double.infinity,
            height: height ?? null,
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
              ),
              child: TextFormField(
                autofocus: false,
                initialValue: initialValue,
                keyboardType: keyboardType,
                focusNode: focusNode,
                obscureText: obscureText,
                enabled: this.enabled,
                validator: this.validator,
                onChanged: this.onChanged,
                textInputAction: TextInputAction.done,

                onFieldSubmitted: this.onFieledSubmit,
                controller: textController,
                maxLines: this.maxline,
                style: TextStyle(
                    fontFamily: "SFProText",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorConstant.textColor),
//          maxLines: null,
//            expands: true,
                cursorColor: ColorConstant.pinkColor,
                //  textInputAction: textInputAction,
//          style: Theme.of(context).textTheme.body2.copyWith(color: Colors.white),
                onTap: () {},
                decoration: InputDecoration(
                  isDense: true,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),

                  contentPadding: new EdgeInsets.symmetric(
                      vertical: paddingVertical ?? 3.0,
                      horizontal: paddingHorizontal ?? 5.0),
                  //contentPadding: EdgeInsets.only(left: 19.0,top: 10),
                  fillColor: editTextBgColor,
                  filled: true,
                  hintText: title,

                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black26,
                    fontFamily: 'SourceSansPro',
                  ),
                  hasFloatingPlaceholder: false,
                  suffixIcon: suffixIcon != null ? suffixIcon : null,
                ),
              ),
            ));
  }
}
