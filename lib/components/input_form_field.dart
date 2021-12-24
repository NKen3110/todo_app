import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final bool obscureText;
  final String obscuringCharacter;
  final Color fillColor;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String hintText;
  final Color hintTextColor;
  final Color cursorColor;
  final Color textColor;
  final List<BoxShadow> boxShadow;
  final TextEditingController controller;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final FocusNode focusNode;
  final String initialValue;
  final bool hideShadowBox;
  final AutovalidateMode autovalidateMode;

  const InputFormField({
    Key key,
    this.fillColor,
    this.prefixIcon,
    this.hintText,
    this.hintTextColor,
    this.cursorColor,
    this.textColor,
    this.validator,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.suffixIcon,
    this.boxShadow,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    this.hideShadowBox = false,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    InputDecoration inputDecoration;
    BoxDecoration boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: hideShadowBox ? [] : boxShadow);
    inputDecoration = InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: hintTextColor),
      errorMaxLines: 2,
      filled: true,
      fillColor: fillColor,
      constraints: BoxConstraints(maxWidth: size.width * 0.8),
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: const EdgeInsetsDirectional.only(start: 19, end: 15),
              child: prefixIcon,
            )
          : null,
      suffixIcon: Padding(
        padding: const EdgeInsetsDirectional.only(start: 5, end: 10),
        child: suffixIcon,
      ),
      contentPadding:
          const EdgeInsets.only(left: 5, right: 5.0, top: 19, bottom: 19),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // borderSide: BorderSide(color: Colors.white10),
        // borderSide: BorderSide.none,
      ),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      // padding: EdgeInsets.symmetric(vertical: 0),
      width: size.width * 0.8,
      decoration: boxDecoration,
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        initialValue: initialValue,
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        obscuringCharacter: obscuringCharacter,
        style: TextStyle(color: textColor),
        cursorColor: cursorColor,
        decoration: inputDecoration,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
