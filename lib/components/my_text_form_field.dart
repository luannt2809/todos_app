import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todos_app/themes/styles.dart';

class MyTextFormField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? inputType;
  final bool? enabled;
  final bool obscureText;
  final List<TextInputFormatter>? formatters;

  const MyTextFormField(
      {super.key,
      required this.text,
      required this.hintText,
      this.controller,
      this.widget,
      this.inputType,
      this.enabled,
      this.formatters,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: Styles.titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            // height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    enabled: enabled,
                    maxLines: obscureText == true ? 1 : null,
                    obscureText: obscureText,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey,
                    controller: controller,
                    keyboardType: inputType,
                    inputFormatters: formatters,
                    decoration: InputDecoration(
                      hintText: hintText,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
