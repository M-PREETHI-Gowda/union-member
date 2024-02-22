import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';

actionBar({required BuildContext context}) {
  return AppBar(
    toolbarHeight: 0,
    backgroundColor: COLORS.white,
  );
}

Widget enableButton(
    {required bool buttonEnabled,
    required VoidCallback onPressed,
    Color? enableColor,
    required String text}) {
  return SizedBox(
    width: SizeConfig.blockWidth * 100,
    height: SizeConfig.blockHeight * 7,
    child: ElevatedButton(
      onPressed: (buttonEnabled == false)
          ? null
          : () {
              onPressed();
            },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              (buttonEnabled == true)
                  ? enableColor ?? COLORS.yellowLight
                  : COLORS.whiteGrey),
          foregroundColor: MaterialStateProperty.all<Color>(COLORS.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2)))),
      child: Text(
        text,
        style: TextStyle(
          color: COLORS.white,
          fontSize: SizeConfig.blockWidth * 4.4,
          fontWeight: FontWeight.w400,
          fontFamily: 'Lato',
        ),
      ),
    ),
  );
}

Widget headingText({required String text}) {
  return Text(
    text,
    style: TextStyle(
      color: COLORS.lightBlack,
      fontSize: SizeConfig.blockWidth * 5,
      fontWeight: FontWeight.w600,
      fontFamily: 'Lato',
    ),
  );
}

Widget normalTextField(
    {required String hintText,
      required TextEditingController controller,
      required TextInputType inputType,
      required ValueChanged onChanged,
      bool? password,
      int? maxLength,
      Widget? suffix,
      required String? Function(String?)? validator}) {
  return Container(
    width: SizeConfig.blockWidth * 100,
    decoration: BoxDecoration(
      color: COLORS.white,
      borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5),
      boxShadow: [
        BoxShadow(
          color: COLORS.lightWhite.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 2,
          offset: Offset(0, 3),
        ),
      ],
    ),
    margin: EdgeInsets.only(top: SizeConfig.blockHeight * 1.5),
    child: TextFormField(
      controller: controller,
      style: TextStyle(
          color: COLORS.lightBlack,
          fontFamily: "Lato",
          fontWeight: FontWeight.w400,
          fontSize: SizeConfig.blockWidth * 4),
      onChanged: onChanged,
      validator: validator,
      obscureText: password ?? false,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.words,
      cursorColor: COLORS.lightWhite,
      decoration: textFieldDecoration(hint: hintText,suffix: suffix),
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
    ),
  );
}

InputDecoration textFieldDecoration(
    {required String hint, Widget? suffix}) {
  return InputDecoration(
    suffixIcon: suffix,
    contentPadding: EdgeInsets.only(
      top: SizeConfig.blockHeight * 2,
      bottom: SizeConfig.blockHeight * 2,
      left: SizeConfig.blockWidth * 5,
      right: SizeConfig.blockWidth * 3,
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: COLORS.lightWhite,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: COLORS.lightWhite,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5)
    ),
    hintText: hint,
    hintStyle: TextStyle(
        color: COLORS.hintTxt,
        fontWeight: FontWeight.w400,
        fontFamily: "Lato",
        fontSize: SizeConfig.blockWidth * 4),
  );
}

Widget salutation ({required String text, required VoidCallback onTap,required Color color, required Color txtColor }) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical:  SizeConfig.blockWidth*2,horizontal: SizeConfig.blockHeight*2),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: COLORS.border,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text,
        style: TextStyle(
            color:txtColor,
            fontFamily: "lato",
            fontSize: SizeConfig.blockWidth * 4,
            fontWeight: FontWeight.w500),),
    ),
  );
}

Widget primaryText ({required String text, required double size}) {
  return Text(
    text,
    style: TextStyle(
        color: COLORS.yellow,
        fontWeight: FontWeight.w400,
        fontFamily: "Lato",
        fontSize: size),
  );
}

Widget subText ({required String text, required double size}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: COLORS.lightBlack,
        fontWeight: FontWeight.w500,
        fontFamily: "Lato",
        fontSize: size),
  );
}

InputDecoration textDecoration(
    {required String hint, Widget? suffix}) {
  return  InputDecoration(
    suffixIcon: suffix,
    hintText: hint,
    hintStyle: TextStyle(
        color: COLORS.hintTxt1,
        fontWeight: FontWeight.w400,
        fontFamily: "Lato",
        fontSize: SizeConfig.blockWidth * 4.2
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color:COLORS.lightWhite),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color:COLORS.lightWhite),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color:COLORS.lightWhite),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color:Colors.red),
    ),
  );
}