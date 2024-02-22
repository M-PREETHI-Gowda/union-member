import 'package:flutter/material.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';

class CustomSnackBar{
  static void showCustomSnackBar({required BuildContext context, required String title}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(title,
            style: TextStyle(
                color: COLORS.white,
                fontFamily: "Lato",
                fontSize: SizeConfig.blockWidth * 4,
                fontWeight: FontWeight.w600),),

        )
    );
  }
}