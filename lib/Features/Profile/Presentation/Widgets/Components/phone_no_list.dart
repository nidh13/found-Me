import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';

class PhoneNoList extends StatefulWidget {
  String initialValue;
  TextEditingController number;

  bool switchValue;
  final String hintText;
  final double bottomPadding;
  final double topPadding;
Function onChanged;
  PhoneNoList(
      {this.initialValue,
      this.number,
      this.switchValue,
      this.hintText,
      this.bottomPadding,
      this.topPadding});

  @override
  PhoneNoListState createState() => new PhoneNoListState();
}

class PhoneNoListState extends State<PhoneNoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.topPadding ?? 12.5,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: MyTextField(
                initialValue: widget.initialValue,
                maxline: 1,
                inputType: TextInputType.multiline,
                editTextBgColor: ColorConstant.textfieldColor,
                hintTextColor: Colors.white54,
                title: widget.hintText,
                onChanged: (value) {
                  widget.initialValue = value;
                  print(widget.initialValue);
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomRight,
                child: CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: widget.switchValue,
                  onChanged: (value) {
                    setState(() {
                      widget.switchValue = value;
                    });
                    print(widget.switchValue);
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.bottomPadding ?? 12.5,
        ),
      ],
    );
  }
}
