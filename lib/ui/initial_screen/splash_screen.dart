import 'dart:async';
import 'package:flutter/material.dart';
import 'package:user_app/components/colors.dart';
import 'package:user_app/components/size_config.dart';
import 'package:user_app/helpers/reuse_widget.dart';
import 'package:user_app/ui/initial_screen/slide_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SlideScreen())));
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: COLORS.white,
      appBar: actionBar(context: context),
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: SizeConfig.blockHeight * 55,
                left: SizeConfig.blockWidth*0,
                child:  Container(
                    height: SizeConfig.blockHeight * 30,
                    width: SizeConfig.blockHeight * 35,
                    margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 1),
                    child: Image.asset(
                        "assets/images/splashBg.png",
                        fit: BoxFit.contain)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    height: SizeConfig.blockHeight * 22,
                    width: SizeConfig.blockHeight * 56,
                    margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 1),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                  Text(
                    "It All Begins Here!!!",
                    style: TextStyle(
                      color: COLORS.black,
                      fontFamily: "lato",
                      fontSize: SizeConfig.blockWidth * 4,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.blockHeight * 0.5),
        child:
        Image.asset(
          "assets/images/splash.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
